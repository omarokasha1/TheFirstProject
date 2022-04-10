import 'course_model.dart';

class CreateContent {
  String? status;
  List<Contents>? contents;

  CreateContent({this.status, this.contents});

  CreateContent.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(new Contents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.contents != null) {
      data['contents'] = this.contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contents {
  String? sId;
  String? contentTitle;
  String? contentDuration;
  String? contentType;
  String? createdAt;
  String? enumType;
  String? imageUrl;
  String? description;
  String? author;

  Contents(
      {this.sId,
      this.contentTitle,
      this.contentDuration,
      this.contentType,
      this.createdAt,
      this.enumType,
      this.imageUrl,
      this.author,
      this.description});

  Contents.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contentTitle = json['contentTitle'];
    contentDuration = json['contentDuration'];
    contentType = json['contentType'];
    createdAt = json['createdAt'];
    enumType = json['enumType'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['contentTitle'] = this.contentTitle;
    data['contentDuration'] = this.contentDuration;
    data['contentType'] = this.contentType;
    data['createdAt'] = this.createdAt;
    data['enumType'] = this.enumType;
    data['imageUrl'] = this.imageUrl;
      data['author'] = this.author;

    return data;
  }
}
