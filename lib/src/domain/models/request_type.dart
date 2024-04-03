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

