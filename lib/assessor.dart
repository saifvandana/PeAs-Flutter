/*
Models an assessor which contains all the data
from the decrypted URL
*/

class Assessor {
  int id;
  String fname;
  String lname;
  String email;
  String team;
  int projectID;

  //Constructor takes the decrypted URL and parses
  //and assigns the instance variables
  Assessor(String data) {
    var split = data.split('\t');
    id = int.parse(split[0]);
    fname = split[1];
    lname = split[2];
    email = split[3];
    team = split[4];
    projectID = int.parse(split[5]);
  }

  //toString method for printing out the object
  //for testing purposes
  @override
  String toString() {
    return "$id $fname $lname $email $team $projectID";
  }
}
