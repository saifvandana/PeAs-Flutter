class AssessmentInfo {
  int projectID;
  String semester;
  String course;
  String projectName;
  List<String> dimensionNames;
  DateTime startTime;
  DateTime endTime;

  AssessmentInfo.fromJson(Map<String, dynamic> json)
      : projectID = int.parse(json['idProject']),
        semester = json['semester'],
        course = json['course'],
        projectName = json['project_name'],
        startTime = DateTime.parse(json['start_time']),
        endTime = DateTime.parse(json['finish_time']),
        dimensionNames = [
          json['dim_name1'],
          json['dim_name2'],
          json['dim_name3'],
          json['dim_name4'],
          json['dim_name5'],
          json['dim_name6'],
          json['dim_name7'],
          json['dim_name8'],
          json['dim_name8'],
          json['dim_name10']
        ];
}
