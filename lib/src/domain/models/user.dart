import 'package:leave_tracker_application/src/utils/constants/encryption.dart';

const String userTableName = "user";
const String userColumnId = "id";
const String userColumnEmpId = "emp_id";
const String userColumnName = "name";
const String userColumnGender = "gender";
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
  String gender;
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
      this.gender,
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
      userColumnGender: gender,
      userColumnDomain: domain,
      userColumnDesignation: designation,
      userColumnJoiningDate: joiningDate.toString(),
      userColumnEmail: email,
      userColumnPassword: encryptPassword(password),
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
      json[userColumnGender] as String,
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
