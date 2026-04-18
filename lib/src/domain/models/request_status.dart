const String requestStatusTableName = "request_status";
const String requestStatusColumnId = "id";
const String requestStatusColumnRequestStatus = "request_status_type";

class RequestStatus {
  final int id;
  final String requestStatus;

  RequestStatus(this.id, this.requestStatus);

  factory RequestStatus.fromJson(Map<String, dynamic> json) {
    return RequestStatus(
      json[requestStatusColumnId] as int,
      json[requestStatusColumnRequestStatus] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      requestStatusColumnId: id,
      requestStatusColumnRequestStatus: requestStatus,
    };
  }
}
