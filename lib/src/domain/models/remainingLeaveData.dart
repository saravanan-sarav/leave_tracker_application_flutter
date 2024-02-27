class RemainingLeave {
  final int id;
  final String categoryName;
  final int AllotedLeave;
  RemainingLeave(this.id, this.categoryName, this.AllotedLeave);
}

List<RemainingLeave> remainingLeaves = [
  RemainingLeave(1, "Compensatory Leave", 2),
  RemainingLeave(3, "Cyclone Leave", 2),
  RemainingLeave(2, "Leave with Pay", 2),
  RemainingLeave(4, "Leave Without Pay", 2),
  RemainingLeave(5, "Permission", 6),
  RemainingLeave(5, "Work From Home", 6),

];