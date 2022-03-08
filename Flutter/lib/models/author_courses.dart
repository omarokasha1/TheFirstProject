class AuthorCourses {
  String? status;
  String? message;
  List<Courses>? courses;

  AuthorCourses({this.status, this.message, this.courses});

  AuthorCourses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
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

class Courses {
  String? sId;
  String? requirements;
  String? title;
  String? language;
  String? description;
  String? imageUrl;
  bool? isPublished;
  List<Contents>? contents;
  String? author;

  Courses(
      {this.sId,
        this.requirements,
        this.title,
        this.language,
        this.description,
        this.imageUrl,
        this.isPublished,
        this.contents,
        this.author});

  Courses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    requirements = json['requirements'];
    title = json['title'];
    language = json['language'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    isPublished = json['isPublished'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['requirements'] = this.requirements;
    data['title'] = this.title;
    data['language'] = this.language;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['isPublished'] = this.isPublished;
    if (this.contents != null) {
      data['contents'] = this.contents!.map((v) => v.toJson()).toList();
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

  Contents(
      {this.sId,
        this.contentTitle,
        this.contentDuration,
        this.imageUrl,
        this.description,
        this.author,});

  Contents.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contentTitle = json['contentTitle'];
    contentDuration = json['contentDuration'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['contentTitle'] = this.contentTitle;
    data['contentDuration'] = this.contentDuration;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    data['author'] = this.author;
    return data;
  }
}