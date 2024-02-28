class UserData {
  int id;
  String empId;
  String name;
  String Domain;
  String designation;
  DateTime joiningDate;
  String email;
  String password;
  DateTime dateOfBirth;
  int TeamId;
  String reportingTo;

  UserData(
      this.id,
      this.empId,
      this.name,
      this.Domain,
      this.designation,
      this.joiningDate,
      this.email,
      this.password,
      this.dateOfBirth,
      this.TeamId,
      this.reportingTo);
}

List<UserData> userDetails = [
  UserData(
      1,
      "1001",
      "Saravanan S",
      "Banking",
      "Intern",
      DateTime(2023, 9, 11),
      "user",
      "1234",
      DateTime(2001, 10, 04),
      2003,
      "101"),
  UserData(
      2,
      "101",
      "SaravanaKumar",
      "Banking",
      "Project Manager",
      DateTime(2021, 9, 11),
      "user2",
      "1234",
      DateTime(1995, 01, 04),
      2003,
      "1"),
  UserData(3, "1", "Admin", "Banking", "Admin", DateTime(2021, 9, 11),
      "admin@kumaran.com", "1234", DateTime(1995, 01, 04), 2003, "1"),
];

class ReportingUserDetail {
  String empId;
  String name;
  String designation;
  String domain;

  ReportingUserDetail(this.empId, this.name, this.designation, this.domain);
}

ReportingUserDetail getReportingUserDetailOfCurrentLoggedInUser(String empId) {
  UserData loggedInUser =
      userDetails.firstWhere((element) => element.empId == empId);
  UserData reportingTo = userDetails
      .firstWhere((element) => element.empId == loggedInUser.reportingTo);
  return ReportingUserDetail(
      reportingTo.empId, reportingTo.name, reportingTo.designation,reportingTo.Domain);
}

UserData? isUserIsValid(
  String email,
  String password,
) {
  for (UserData user in userDetails) {
    if (user.email == email && user.password == password) {
      return user;
    }
  }
  return null;
}
