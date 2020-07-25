/*
Models an assessment of one peer
Holds all information received from an 'assessment' request
And the information received from a 'peer' request to the API
Both pieces of data are combined to create an object that holds
the information about one person's assessment along with their name,
ID and other details
*/

class PeerAssessment {
  String fname;
  String lname;
  int assessmentID;
  int assessorID;
  int assesseeID;
  int projectID;
  String team;
  //List of integers that stores the rating for this peer
  //for all dimensions in order
  List<int> dimensionRatings;
  String comments;

  //From JSON function allows the object to be created directly from a JSON input
  //This allows us to take the server JSON resonse and directly convert it to an
  //object without any complications
  PeerAssessment.fromJson(Map<String, dynamic> json, Map<String, dynamic> names)
      : assessmentID = int.parse(json['idAssessment']),
        assessorID = int.parse(json['Assessor']),
        assesseeID = int.parse(json['Assessee']),
        projectID = int.parse(json['Project']),
        team = json['Team'],
        comments = json['Comments'],
        fname = names['FirstName'],
        lname = names['LastName'],
        dimensionRatings = [
          (int.parse(json['Dimension1'])),
          (int.parse(json['Dimension2'])),
          (int.parse(json['Dimension3'])),
          (int.parse(json['Dimension4'])),
          (int.parse(json['Dimension5'])),
          (int.parse(json['Dimension6'])),
          (int.parse(json['Dimension7'])),
          (int.parse(json['Dimension8'])),
          (int.parse(json['Dimension9'])),
          (int.parse(json['Dimension10'])),
        ];

  //toJSON is used to convert a PeerAssessment object to a JSON object
  //This is used when sending an updated assessment to the server
  //Only the information required by the server in an assessment update is
  //included in the JSON, formatting is also followed
  Map<String, dynamic> toJson() => {
        'dimensions': dimensionRatings,
        'feedback': comments,
        'id': assessmentID,
      };
}
