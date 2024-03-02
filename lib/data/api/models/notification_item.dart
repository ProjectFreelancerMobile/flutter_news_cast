import 'package:get/get.dart';

class NotificationItem {
  String? id;
  String? title;
  String? content;
  String? receiver;
  String? type;
  String? notify;
  String? booking;
  RxBool? isRead;
  String? image;
  dynamic createdAt;
  dynamic updatedAt;

  NotificationItem({this.id, this.title, this.content, this.receiver, this.type, this.notify, this.booking, this.isRead, this.image, this.createdAt, this.updatedAt});

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        content: json["content"] ?? "--",
        receiver: json["receiver"] ?? "",
        type: json["type"] ?? "",
        notify: json["notify"] ?? "",
        booking: json["booking"] ?? "",
        image: json["image"],
        isRead: (json["isRead"] != null ? json["isRead"] as bool : false).obs,
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "title": title ?? "",
        "content": content ?? "",
        "receiver": receiver ?? "",
        "type": type ?? "",
        "notify": notify ?? "",
        "booking": booking ?? "",
        "isRead": isRead != null ? isRead!.value : false,
        "image": image,
        "createdAt": createdAt ?? 0,
        "updatedAt": updatedAt ?? 0
      };
}
