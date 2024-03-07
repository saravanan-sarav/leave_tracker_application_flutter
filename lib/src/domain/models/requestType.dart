const String requestTypeTableName = "request_type";
const String requestTypeColumnId = "id";
const String requestTypeColumnType = "type";

class RequestType {
  final int id;
  final String type;

  RequestType(this.id, this.type);

  factory RequestType.fromJson(Map<String, dynamic> json) {
    return RequestType(
      json[requestTypeColumnId],
      json[requestTypeColumnType],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      requestTypeColumnId: id,
      requestTypeColumnType: type,
    };
  }
}

final List<RequestType> requestTypes = [
  RequestType(1, "Compensatory Off"),
  RequestType(2, "Cyclone Leave"),
  RequestType(3, "Leave Without Pay"),
  RequestType(4, "Leave with Pay"),
  RequestType(5, "Permission"),
  RequestType(6, "Work From Home")
];
