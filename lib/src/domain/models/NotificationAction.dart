const String notificationActionTableName = "notification_action";
const String notificationActionColumnId = "id";
const String notificationActionColumnActions = "actions";

class NotificationAction {
  final int id;
  final String actions;

  NotificationAction(this.id, this.actions);

  factory NotificationAction.fromJson(Map<String, dynamic> json) {
    return NotificationAction(
      json['id'],
      json['actions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'actions': actions,
    };
  }
}

List<NotificationAction> notificationActionList = [
  NotificationAction(1, "Created a Request"),
  NotificationAction(2, "Request Accepted"),
  NotificationAction(3, "Request Pending"),
  NotificationAction(4, "Request Rejected"),
];
