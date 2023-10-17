// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResourceDownloadModel {
  String officeId;
  String catUploadId;
  String userId;
  String downloadTitle;
  String url;
  String downloadDetails;
  String downloadOrder;
  String downloadFile;
  String downloadCount;
  ResourceDownloadModel({
    required this.officeId,
    required this.catUploadId,
    required this.userId,
    required this.downloadTitle,
    required this.url,
    required this.downloadDetails,
    required this.downloadOrder,
    required this.downloadFile,
    required this.downloadCount,
  });

  ResourceDownloadModel copyWith({
    String? officeId,
    String? catUploadId,
    String? userId,
    String? downloadTitle,
    String? url,
    String? downloadDetails,
    String? downloadOrder,
    String? downloadFile,
    String? downloadCount,
  }) {
    return ResourceDownloadModel(
      officeId: officeId ?? this.officeId,
      catUploadId: catUploadId ?? this.catUploadId,
      userId: userId ?? this.userId,
      downloadTitle: downloadTitle ?? this.downloadTitle,
      url: url ?? this.url,
      downloadDetails: downloadDetails ?? this.downloadDetails,
      downloadOrder: downloadOrder ?? this.downloadOrder,
      downloadFile: downloadFile ?? this.downloadFile,
      downloadCount: downloadCount ?? this.downloadCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'officeId': officeId,
      'catUploadId': catUploadId,
      'userId': userId,
      'downloadTitle': downloadTitle,
      'url': url,
      'downloadDetails': downloadDetails,
      'downloadOrder': downloadOrder,
      'downloadFile': downloadFile,
      'downloadCount': downloadCount,
    };
  }

  factory ResourceDownloadModel.fromMap(Map<String, dynamic> map) {
    return ResourceDownloadModel(
      officeId: map['office_id'] ?? "",
      catUploadId: map['cat_upload_id'] ?? "",
      userId: map['user_id'] ?? "",
      downloadTitle: map['download_title'] ?? "",
      url: map['url'] ?? "",
      downloadDetails: map['download_details'] ?? "",
      downloadOrder: map['download_order'] ?? "",
      downloadFile: map['download_file'] ?? "",
      downloadCount: map['download_count'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ResourceDownloadModel.fromJson(String source) =>
      ResourceDownloadModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResourceDownloadModel(officeId: $officeId, catUploadId: $catUploadId, userId: $userId, downloadTitle: $downloadTitle, url: $url, downloadDetails: $downloadDetails, downloadOrder: $downloadOrder, downloadFile: $downloadFile, downloadCount: $downloadCount)';
  }

  @override
  bool operator ==(covariant ResourceDownloadModel other) {
    if (identical(this, other)) return true;

    return other.officeId == officeId &&
        other.catUploadId == catUploadId &&
        other.userId == userId &&
        other.downloadTitle == downloadTitle &&
        other.url == url &&
        other.downloadDetails == downloadDetails &&
        other.downloadOrder == downloadOrder &&
        other.downloadFile == downloadFile &&
        other.downloadCount == downloadCount;
  }

  @override
  int get hashCode {
    return officeId.hashCode ^
        catUploadId.hashCode ^
        userId.hashCode ^
        downloadTitle.hashCode ^
        url.hashCode ^
        downloadDetails.hashCode ^
        downloadOrder.hashCode ^
        downloadFile.hashCode ^
        downloadCount.hashCode;
  }
}
