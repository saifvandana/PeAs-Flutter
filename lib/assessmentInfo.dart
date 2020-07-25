/*
Models an object that stores all information about an assessment
The information stored comes from making a 'project' request to the
API with the projectID from the decrypted URL
*/

class AssessmentInfo {
  int projectID;
  String semester;
  String course;
  String projectName;
  //List of the dimension names in order
  List<String> dimensionNames;
  //Dates used to compare and check assessment validity
  DateTime startTime;
  DateTime endTime;

  //Constructor used to make object directly from the JSON
  //recieved from the API
  //Makes for easier construction and management of the data
  AssessmentInfo.fromJson(Map<String, dynamic> json)
      : projectID = int.parse(json['idProject']),
        semester = json['semester'],
        course = json['course'],
        projectName = json['project_name'],

        //To convert the date-time format from the server
        //to a DateTime object
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
