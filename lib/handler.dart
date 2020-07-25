import 'dart:convert';
import 'package:http/http.dart' as http;
import 'assessmentInfo.dart';
import 'assessor.dart';
import 'crypt.dart';
import 'peerAssessment.dart';

/*
This class handles all object creation and HTTP requests
Provides all functions necessary to fetch and post data to database
No direct HTTP request should be made, everything should be done through
the handler
*/

class Handler {
/*
  The following describes rougly what data each class holds
  and where the data comes from

  Assessor {
    URL decryption gives
      id
      fname
      lname
      email
      team
      projectID
  }
  AssessmentInfo{
    Requesting project with projectID gives:
      projectID
      semester
      course
      projectName
      dimension names (up to 10)
      start time
      end time

    Requesting now gives current time according to server:
      Used to check validity of assessment
  }
 
  PeerAssessment{
    Requesting assessment with assessor student id and project id gives
      For each teammate
      {
        assessmentID
        assessor id
        assessee id
        ProjectID
        Team name
        rating for each dimension up to 10
        comments
      }

    //Although this is a separate API request
    //it was combined with each peer's assessment data
    //for convenience
    Requesting peer with peer student id gives
      Peer's first and last name

    //The JSON format the server expects for a
    //assessment update
    Posting assessment update
      * {
      * 		"dimensions": [4, 5, 3, 2...],   -> Must be array and cannot be empty!
      * 		"feedback":	"hardwordking!",
      * 		"id":	1642
      * }
  }

  The functions of this class simplify the process of
  getting and fetching data.
  SAMPLE USAGE OF THIS CLASS' METHODS:
    var assessor = Handler.getAssessor(
        "http://139.179.38.78/PeAsF/a.php?q=ENCRYPTEDPART");

    var assessmentInfo = await Handler.getAssessmentInfo(assessor);

    var isValid = await Handler.checkAssessmentValidity(assessmentInfo);

    var peerAssessments = await Handler.getPeerAssessments(assessor);

    var postResponse = await Handler.postAssessmentUpdate(peerAssessments[0]);
*/

  //The base address to which all fetch and post requests are made
  //Can be updated in case the server is moved to a different address
  static final String _baseRequestURL = "http://139.179.38.78/PeAsF/api.php?";

  //The base address for all assessment links
  //Can be updated in case the assessment links are changed
  static final String baseAssessmentURL = "http://139.179.38.78/PeAsF/a.php?q=";

  //The constants that are instantiated on object creation
  //Just to avoid repeatedly encrypting the same phrases
  static final String _requestNow = Crypt.encrypt("now");
  static final String _requestProject = Crypt.encrypt("project");
  static final String _requestAssessment = Crypt.encrypt("assessment");
  static final String _requestPeer = Crypt.encrypt("peer");

  //Takes the encyrpted assessement URL
  //decrypts it
  //And returns an Assessor object which contains
  //all data from the link
  static Assessor getAssessor(String url) {
    var encrypted = url.substring(baseAssessmentURL.length);
    var decrypted = Crypt.decrypt(encrypted);
    return Assessor(decrypted);
  }

  //Takes an Assessor object as input
  //Uses the projectID held in the assessor
  //To make a 'project' request and returns
  //an AssessmentInfo object which contains all
  //data from the request reponse
  static Future<AssessmentInfo> getAssessmentInfo(Assessor assessor) async {
    //Putting together the request URL using the base request URL
    //and the encrypted projectID
    var requestURL = _baseRequestURL +
        'request=' +
        _requestProject +
        '&pid=' +
        Crypt.encrypt((assessor.projectID).toString());

    //Makes the request
    var response = await http.get(requestURL);
    //Decrypts the response
    var decrypted = Crypt.decrypt(response.body);
    //Converts the JSON string into a usable JSON object
    var encoded = jsonDecode(decrypted);
    //Creates and returns an AssessmentInfo object
    //which is constructed directly from the JSON response
    return AssessmentInfo.fromJson(encoded);
  }

  //Used to check if an assessment is valid by comparing
  //its start and end times with the current time of the server
  //Returns 0 if valid, -1 if not started yet, 1 if expired
  //Takes an AssessmentInfo object which is the assessment
  //whose validity is being checked
  static Future<int> checkAssessmentValidity(
      AssessmentInfo assessmentInfo) async {
    //Putting together the request url to get the current server time
    var requestURL = _baseRequestURL + 'request=' + _requestNow;
    //Makes the request
    var response = await http.get(requestURL);
    //Decrypts the response string
    var decrypted = Crypt.decrypt(response.body);
    //Converts the decrypted JSON string to a usable JSON object
    var encoded = jsonDecode(decrypted);
    //Parses the date-time response to create a DateTime object
    var now = DateTime.parse(encoded['NOW()']);

    //Checks if the current server time is both
    //after the start time and before the end time
    //If so, it is valid, else returns not yet started
    //or expired accordingly
    if (now.isBefore(assessmentInfo.startTime)) {
      return -1;
    } else if (now.isAfter(assessmentInfo.endTime)) {
      return 1;
    } else {
      return 0;
    }
  }

  //Given an assessor object, it fetcheds all the peer assessments
  //using the projectID and the assessor's id
  //Returns a List of PeerAssessment objects
  static Future<List<PeerAssessment>> getPeerAssessments(
      Assessor assessor) async {
    List<PeerAssessment> result = [];
    //Putting together the request url
    var requestURL = _baseRequestURL +
        'request=' +
        _requestAssessment +
        '&pid=' +
        Crypt.encrypt((assessor.projectID).toString()) +
        '&myid=' +
        Crypt.encrypt((assessor.id).toString());

    //Gets the request response
    //Decrypts the response
    //Creates JSON object from the string
    var response = await http.get(requestURL);
    var decrypted = Crypt.decrypt(response.body);
    var decoded = jsonDecode(decrypted);

    //Generating each PeerAssessment object
    //And adding them to the list
    for (var i = 0; i < decoded.length; i++) {
      //To combine the peer assessment information
      //with each peer's name and surname,
      //two request are made separately and
      //their responses are used to create one peerAssessment object
      var part1 = decoded[i];
      var requestURL = _baseRequestURL +
          'request=' +
          _requestPeer +
          '&peerid=' +
          Crypt.encrypt((part1['Assessee']).toString());
      var response = await http.get(requestURL);
      var decrypted = Crypt.decrypt(response.body);

      //Getting the name and surname
      var part2 = jsonDecode(decrypted);
      //Creating the object directly from the JSON response
      //and adding them to the list
      result.add(PeerAssessment.fromJson(part1, part2));
    }

    //The generated list is returned
    return result;
  }

  //Posts an updated PeerAssessment object
  static Future<String> postAssessmentUpdate(
      PeerAssessment peerAssessment) async {
    //Converting the object directly to json
    //using to the toJson() function defined
    //in the PeerAssessment class
    var encoded = jsonEncode(peerAssessment);

    //Encrypts the JSON
    var encrypted = Crypt.encrypt(encoded);
    //Takes the post request URL
    var requestURL = _baseRequestURL;
    //Posts
    var response = await http.post(requestURL, body: encrypted);
    //Returns the server response as a string
    return Crypt.decrypt(response.body);
  }
}
