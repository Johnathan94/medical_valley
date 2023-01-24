class NotificationModel {
  final int id;
  final String statusName, description, notificationTime, date, icon;

  NotificationModel(this.id, this.statusName, this.description,
      this.notificationTime, this.date,this.icon, );
  Map<String, String> toMap() {
    Map<String, String> notifications = {};
    notifications["id"] = id.toString();
    notifications["statusName"] = statusName;
    notifications["description"] = description;
    notifications["notificationTime"] = notificationTime;
    notifications["date"] = date;
    notifications["icon"] = icon;
    return notifications;
  }
}
