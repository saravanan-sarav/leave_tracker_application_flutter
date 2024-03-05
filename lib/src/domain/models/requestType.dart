class RequestType {
  final int id;
  final String type;

  RequestType(this.id, this.type);
}

final List<RequestType> requestTypes = [
  RequestType(1, "Compensatory Off"),
  RequestType(2, "Cyclone Leave"),
  RequestType(3, "Leave Without Pay"),
  RequestType(4, "Leave with Pay"),
  RequestType(5, "Permission")
];