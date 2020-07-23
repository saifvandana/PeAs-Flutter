class PeerAssessment {
  String fname;
  String lname;
  int assessmentID;
  int assessorID;
  int assesseeID;
  int projectID;
  String team;
  List<int> dimensionRatings;
  String comments;

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

  Map<String, dynamic> toJson() => {
        'dimensions': dimensionRatings,
        'feedback': comments,
        'id': assessmentID,
      };
}
