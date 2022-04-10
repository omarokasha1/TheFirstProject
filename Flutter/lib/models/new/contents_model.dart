import 'package:lms/models/new/courses_model.dart';

class ContentsModel {
  String? status;
  String? message;
  List<Contentss>? contents;

  ContentsModel({this.status, this.message, this.contents});

  ContentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['contents'] != null) {
      contents = <Contentss>[];
      json['contents'].forEach((v) {
        contents!.add(Contentss.fromJson(v));
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

class Contentss {
  bool? isFinished;
  String? sId;
  String? contentTitle;
  String? contentDuration;
  String? imageUrl;
  String? description;
  Author? author;

  Contentss(
      {this.isFinished,
        this.sId,
        this.contentTitle,
        this.contentDuration,
        this.imageUrl,
        this.description,
        this.author,});

  Contentss.fromJson(Map<String, dynamic> json) {
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