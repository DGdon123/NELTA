
import 'dart:convert';

class ResoucesModel {
  int id;
  String title;
  String type;
  String userType;
  String displayUser;
  String content;
  String date;
  String file;
  String status;
  ResoucesModel({
    required this.id,
    required this.title,
    required this.type,
    required this.userType,
    required this.displayUser,
    required this.content,
    required this.date,
    required this.file,
    required this.status,
  });

  // factory ResoucesModel.fromJson(Map<String, dynamic> json) => ResoucesModel(
  //       id: json["id"],
  //       title: json["title"],
  //       type: json["type"],
  //       userType: json["user_type"],
  //       displayUser: json["display_user"],
  //       content: json["content"],
  //       date:json["date"],
  //       file: json["file"],
  //       status:json["status"],

  //     );

  ResoucesModel copyWith({
    int? id,
    String? title,
    String? type,
    String? userType,
    String? displayUser,
    String? content,
    String? date,
    String? file,
    String? status,
  }) {
    return ResoucesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      userType: userType ?? this.userType,
      displayUser: displayUser ?? this.displayUser,
      content: content ?? this.content,
      date: date ?? this.date,
      file: file ?? this.file,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'type': type,
      'userType': userType,
      'displayUser': displayUser,
      'content': content,
      'date': date,
      'file': file,
      'status': status,
    };
  }

  factory ResoucesModel.fromMap(Map<String, dynamic> map) {
    return ResoucesModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? "",
      type: map['type'] ?? "",
      userType: map['user_type'] ?? "",
      displayUser: map['display_user'] ?? "",
      content: map['content'] ?? "",
      date: map['date'] ?? "",
      file: map['file'] ?? "",
      status: map['status'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ResoucesModel.fromJson(String source) =>
      ResoucesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResoucesModel(id: $id, title: $title, type: $type, userType: $userType, displayUser: $displayUser, content: $content, date: $date, file: $file, status: $status)';
  }

  @override
  bool operator ==(covariant ResoucesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.type == type &&
        other.userType == userType &&
        other.displayUser == displayUser &&
        other.content == content &&
        other.date == date &&
        other.file == file &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        type.hashCode ^
        userType.hashCode ^
        displayUser.hashCode ^
        content.hashCode ^
        date.hashCode ^
        file.hashCode ^
        status.hashCode;
  }
}
