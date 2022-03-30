import 'package:lms/models/new/courses_model.dart';

class ContentsModel {
  String? status;
  String? message;
  List<Contents>? contents;

  ContentsModel({this.status, this.message, this.contents});

  ContentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contents {
  bool? isFinished;
  String? sId;
  String? contentTitle;
  String? contentDuration;
  String? imageUrl;
  String? description;
  Author? author;

  Contents(
      {this.isFinished,
        this.sId,
        this.contentTitle,
        this.contentDuration,
        this.imageUrl,
        this.description,
        this.author,});

  Contents.fromJson(Map<String, dynamic> json) {
    isFinished = json['isFinished'];
    sId = json['_id'];
    contentTitle = json['contentTitle'];
    contentDuration = json['contentDuration'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    author =
    json['author'] != null ? Author.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isFinished'] = isFinished;
    data['_id'] = sId;
    data['contentTitle'] = contentTitle;
    data['contentDuration'] = contentDuration;
    data['imageUrl'] = imageUrl;
    data['description'] = description;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    return data;
  }
}