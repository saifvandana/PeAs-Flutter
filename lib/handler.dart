import 'dart:convert';
import 'package:http/http.dart' as http;
import 'assessmentInfo.dart';
import 'assessor.dart';
import 'crypt.dart';
import 'peerAssessment.dart';

class Handler {
/*
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

    Requesting peer with peer student id gives
      Peer's first and last name

    Posting assessment update
      * {
      * 		"dimensions": [4, 5, 3, 2...],   -> Must be array and cannot be empty!
      * 		"feedback":	"hardwordking!",
      * 		"id":	1642
      * }
  }

  SAMPLE USAGE OF THIS CLASS' METHODS:
    var assessor = Handler.getAssessor(
        "http://139.179.38.78/PeAsF/a.php?q=ckQzSXFvVDdCTy9WYm9nVURxb1lVeGF6eU5YWWZnckw0YS96aXQ0MDZrc3hmbDd4STQzV1k0UGdmVGxnb3dHSldvMXBNMThuOExYWWhBPT0");

    var assessmentInfo = await Handler.getAssessmentInfo(assessor);

    var isValid = await Handler.checkAssessmentValidity(assessmentInfo);

    var peerAssessments = await Handler.getPeerAssessments(assessor);

    var postResponse = await Handler.postAssessmentUpdate(peerAssessments[0]);
*/

  static final String _baseRequestURL = "http://139.179.38.78/PeAsF/api.php?";
  static final String baseAssessmentURL = "http://139.179.38.78/PeAsF/a.php?q=";
  static final String _requestNow = Crypt.encrypt("now");
  static final String _requestProject = Crypt.encrypt("project");
  static final String _requestAssessment = Crypt.encrypt("assessment");
  static final String _requestPeer = Crypt.encrypt("peer");

  static Assessor getAssessor(String url) {
    var encrypted = url.substring(baseAssessmentURL.length);
    var decrypted = Crypt.decrypt(encrypted);
    return Assessor(decrypted);
  }

  static Future<AssessmentInfo> getAssessmentInfo(Assessor assessor) async {
    var requestURL = _baseRequestURL +
        'request=' +
        _requestProject +
        '&pid=' +
        Crypt.encrypt((assessor.projectID).toString());

    var response = await http.get(requestURL);
    var decrypted = Crypt.decrypt(response.body);
    var encoded = jsonDecode(decrypted);
    return AssessmentInfo.fromJson(encoded);
  }

  //Returns 0 if valid, -1 if not started, 1 if expired
  static Future<int> checkAssessmentValidity(
      AssessmentInfo assessmentInfo) async {
    var requestURL = _baseRequestURL + 'request=' + _requestNow;
    var response = await http.get(requestURL);
    var decrypted = Crypt.decrypt(response.body);
    var encoded = jsonDecode(decrypted);
    var now = DateTime.parse(encoded['NOW()']);

    if (now.isBefore(assessmentInfo.startTime)) {
      return -1;
    } else if (now.isAfter(assessmentInfo.endTime)) {
      return 1;
    } else {
      return 0;
    }
  }

  static Future<List<PeerAssessment>> getPeerAssessments(
      Assessor assessor) async {
    List<PeerAssessment> result = [];
    var requestURL = _baseRequestURL +
        'request=' +
        _requestAssessment +
        '&pid=' +
        Crypt.encrypt((assessor.projectID).toString()) +
        '&myid=' +
        Crypt.encrypt((assessor.id).toString());
    var response = await http.get(requestURL);
    var decrypted = Crypt.decrypt(response.body);
    var decoded = jsonDecode(decrypted);

    for (var i = 0; i < decoded.length; i++) {
      var part1 = decoded[i];
      var requestURL = _baseRequestURL +
          'request=' +
          _requestPeer +
          '&peerid=' +
          Crypt.encrypt((part1['Assessee']).toString());
      var response = await http.get(requestURL);
      var decrypted = Crypt.decrypt(response.body);
      var part2 = jsonDecode(decrypted);
      result.add(PeerAssessment.fromJson(part1, part2));
    }

    return result;
  }

  static Future<String> postAssessmentUpdate(
      PeerAssessment peerAssessment) async {
    var encoded = jsonEncode(peerAssessment);
    var encrypted = Crypt.encrypt(encoded);
    var requestURL = _baseRequestURL;
    var response = await http.post(requestURL, body: encrypted);
    return Crypt.decrypt(response.body);
  }
}
