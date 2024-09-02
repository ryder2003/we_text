
class Messages {

  Messages({
    required this.msg,
    required this.toId,
    required this.read,
    required this.type, required this.fromId,
    required this.sent
  });

  late String msg;
  late String toId;
  late String read;
  late Type type;
  late String fromId;
  late String sent;

  Messages.fromJson(Map<String, dynamic> json) {
    msg = json["msg"].toString();
    toId = json["toId"].toString();
    read = json["read"].toString();
    type = json["type"].toString() == Type.image.name ? Type.image : Type.text;
    fromId = json["fromId"].toString();
    sent = json["sent"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["msg"] = msg;
    data["toId"] = toId;
    data["read"] = read;
    data["type"] = type.name;
    data["fromId"] = fromId;
    data["sent"] = sent;
    return data;
  }
}

enum Type{ image, text}