class NoticesModel {
  NoticesModel({
    required this.id,
    required this.officeId,
    required this.userId,
    required this.noticeDate,
    required this.noticeTitle,
    required this.noticeDetails,
    required this.noticeImage,
    required this.noticeDisplayOrder,
    required this.noticeStatus,
  });

  int id;
  String officeId;
  String userId;
  String noticeDate;
  String noticeTitle;
  String noticeDetails;
  String noticeImage;
  String noticeDisplayOrder;
  String noticeStatus;

  factory NoticesModel.fromJson(Map<String, dynamic> json) => NoticesModel(
        id: json["id"] ?? 0,
        officeId: json["office_id"] ?? "",
        userId: json["user_id"] ?? "",
        noticeDate: json["notice_date"] ?? "",
        noticeTitle: json["notice_title"] ?? "",
        noticeDetails: json["notice_details"] ?? "",
        noticeImage: json["notice_image"] ?? "",
        noticeDisplayOrder: json["notice_display_order"] ?? "",
        noticeStatus: json["notice_status"] ?? "",
      );
}
