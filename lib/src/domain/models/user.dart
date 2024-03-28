const String userTableName = "user";
const String userColumnId = "id";
const String userColumnEmpId = "emp_id";
const String userColumnName = "name";
const String userColumnDomain = "domain";
const String userColumnDesignation = "designation";
const String userColumnJoiningDate = "joining_date";
const String userColumnEmail = "email";
const String userColumnPassword = "password";
const String userColumnDateOfBirth = "date_of_birth";
const String userColumnTeamId = "team_id";
const String userColumnReportingTo = "reporting_to_emp_id";

class UserData {
  int id;
  String empId;
  String name;
  String domain;
  String designation;
  DateTime joiningDate;
  String email;
  String password;
  DateTime dateOfBirth;
  int teamId;
  String reportingTo;

  UserData(
      this.id,
      this.empId,
      this.name,
      this.domain,
      this.designation,
      this.joiningDate,
      this.email,
      this.password,
      this.dateOfBirth,
      this.teamId,
      this.reportingTo);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      userColumnId: id,
      userColumnEmpId: empId,
      userColumnName: name,
      userColumnDomain: domain,
      userColumnDesignation: designation,
      userColumnJoiningDate: joiningDate.toString(),
      userColumnEmail: email,
      userColumnPassword: password,
      userColumnDateOfBirth: dateOfBirth.toString(),
      userColumnTeamId: teamId,
      userColumnReportingTo: reportingTo
    };
    return map;
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      json[userColumnId],
      json[userColumnEmpId] as String,
      json[userColumnName] as String,
      json[userColumnDomain] as String,
      json[userColumnDesignation] as String,
      DateTime.parse(json[userColumnJoiningDate]),
      json[userColumnEmail] as String,
      json[userColumnPassword] as String,
      DateTime.parse(json[userColumnDateOfBirth]),
      json[userColumnTeamId] as int,
      json[userColumnReportingTo] as String,
    );
  }
}

List<UserData> userDetails = [
  UserData(
      1,
      "1001",
      "Saravanan S",
      "Banking",
      "Intern",
      DateTime(2023, 9, 11),
      "saravanan@kumaran.com",
      "Saravanan@123",
      DateTime(2001, 10, 04),
      2003,
      "101"),
  UserData(
      2,
      "1002",
      "Gnanesh",
      "Banking",
      "Intern",
      DateTime(2023, 9, 11),
      "gnanesh@kumaran.com",
      "Gnanesh@123",
      DateTime(2002, 02, 10),
      2003,
      "101"),
  UserData(
      3,
      "101",
      "SaravanaKumar",
      "Banking",
      "Project Manager",
      DateTime(2020, 4, 11),
      "saravanankumar@kumaran.com",
      "Skumar@123",
      DateTime(1996, 01, 10),
      2003,
      "102"),
  UserData(
      4,
      "102",
      "Lohith Hariharan",
      "Banking",
      "Senior Project Manager",
      DateTime(2021, 9, 11),
      "lohith@kumaran.com",
      "lohith@123",
      DateTime(1995, 01, 04),
      2003,
      "1"),
  UserData(5, "1", "Admin", "Banking", "Admin", DateTime(2021, 9, 11), "admin@",
      "1234", DateTime(1995, 01, 04), 2003, "1"),
];