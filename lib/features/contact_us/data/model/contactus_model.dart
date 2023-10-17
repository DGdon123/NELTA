// To parse this JSON data, do
//
//     final eventDetailModel = eventDetailModelFromJson(jsonString);

class ContactUsModel {
  ContactUsModel({
    required this.id,
    required this.officeTypeId,
    required this.parentId,
    required this.districtId,
    required this.officeCode,
    required this.officeName,
    required this.officeNumber,
    required this.officeHeadName,
    required this.officeEmail,
    required this.officeHeadPhoto,
    required this.officeFbUrl,
    required this.officeYoutubeUrl,
    required this.officeTwitterUrl,
    required this.officeLogo,
    required this.officeFax,
    required this.officePobox,
    required this.aboutOffice,
    required this.officePath,
    required this.officeStatus,
  });

  int id;
  String officeTypeId;
  String parentId;
  String districtId;
  String officeCode;
  String officeName;
  String officeNumber;
  String officeHeadName;
  String officeEmail;
  String officeHeadPhoto;
  String officeFbUrl;
  String officeYoutubeUrl;
  String officeTwitterUrl;
  String officeLogo;
  String officeFax;
  String officePobox;
  String aboutOffice;
  String officePath;
  String officeStatus;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
        id: json["id"] ?? 0,
        officeTypeId: json["office_type_id"] ?? "",
        parentId: json["parent_id"] ?? "",
        districtId: json["district_id"] ?? "",
        officeCode: json["office_code"] ?? "",
        officeName: json["office_name"] ?? "",
        officeNumber: json["office_number"] ?? "",
        officeHeadName: json["office_head_name"] ?? "",
        officeEmail: json["office_email"] ?? "",
        officeHeadPhoto: json["office_head_photo"] ?? "",
        officeFbUrl: json["office_fb_url"] ?? "",
        officeYoutubeUrl: json["office_youtube_url"] ?? "",
        officeTwitterUrl: json["office_twitter_url"] ?? "",
        officeLogo: json["office_logo"] ?? "",
        officeFax: json["office_fax"] ?? "",
        officePobox: json["office_pobox"] ?? "",
        aboutOffice: json["about_office"] ?? "",
        officePath: json["office_path"] ?? "",
        officeStatus: json["office_status"] ?? "",
      );
}
