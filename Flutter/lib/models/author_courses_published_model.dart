class authorCoursesPublishedModel {
  String? status;
  String? message;
  List<Coursess>? courses;

  authorCoursesPublishedModel({this.status, this.message, this.courses});

  authorCoursesPublishedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['courses'] != null) {
      courses = <Coursess>[];
      json['courses'].forEach((v) {
        courses!.add(new Coursess.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coursess {
  String? sId;
  String? requirements;
  String? title;
  String? language;
  String? description;
  String? imageUrl;
  List<String>? wishers;
  bool? isPublished;
  List<Contents>? contents;
  List<String>? learner;
  String? author;

  Coursess(
      {this.sId,
        this.requirements,
        this.title,
        this.language,
        this.description,
        this.imageUrl,
        this.wishers,
        this.isPublished,
        this.contents,
        this.learner,
        this.author});

  Coursess.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    requirements = json['requirements'];
    title = json['title'];
    language = json['language'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    if (json['wishers'] != null) {
      wishers = <String>[];
      json['wishers'].forEach((v) {
        wishers!.add(v);
      });
    }
    isPublished = json['isPublished'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(new Contents.fromJson(v));
      });
    }
    if (json['learner'] != null) {
      learner = <String>[];
      json['learner'].forEach((v) {
        learner!.add(v);
      });
    }
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['requirements'] = this.requirements;
    data['title'] = this.title;
    data['language'] = this.language;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    if (this.wishers != null) {
      data['wishers'] = this.wishers!.toList();
    }
    data['isPublished'] = this.isPublished;
    if (this.contents != null) {
      data['contents'] = this.contents!.toList();
    }
    if (this.learner != null) {
      data['learner'] = this.learner!.toList();
    }
    data['author'] = this.author;
    return data;
  }
}

class Contents {
  String? sId;
  String? contentTitle;
  String? contentDuration;
  String? imageUrl;
  String? description;
  String? author;
  List<String>? courses;

  Contents(
      {this.sId,
        this.contentTitle,
        this.contentDuration,
        this.imageUrl,
        this.description,
        this.author,
        this.courses});

  Contents.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contentTitle = json['contentTitle'];
    contentDuration = json['contentDuration'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    author = json['author'];
    if (json['courses'] != null) {
      courses = <String>[];
      json['courses'].forEach((v) {
        courses!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['contentTitle'] = this.contentTitle;
    data['contentDuration'] = this.contentDuration;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    data['author'] = this.author;
    if (this.courses != null) {
      data['courses'] = this.courses!.toList();
    }
    return data;
  }
}
