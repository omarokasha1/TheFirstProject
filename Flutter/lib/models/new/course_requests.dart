class CourseRequestModel {
  String? status;
  String? message;
  List<CourseRequests>? courseRequests = [];

  CourseRequestModel({this.status, this.message, this.courseRequests});

  CourseRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    json['courseRequests'].forEach((v) {
      courseRequests!.add(CourseRequests.fromJson(v));
    });
  }
}

class CourseRequests {
  String? sId;
  AuthorId? authorId;
  CourseId? courseId;

  CourseRequests({this.sId, this.authorId, this.courseId});

  CourseRequests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    authorId = AuthorId.fromJson(json['authorId']);
    courseId = CourseId.fromJson(json['courseId']);
  }
}

class AuthorId {
  String? sId;
  String? userName;
  String? imageUrl;

  AuthorId({
    this.sId,
    this.userName,
    this.imageUrl,
  });

  AuthorId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    imageUrl = json['imageUrl'];
  }
}

class CourseId {
  String? sId;
  String? title;
  String? imageUrl;

  CourseId({
    this.sId,
    this.title,
    this.imageUrl,
  });

  CourseId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    imageUrl = json['imageUrl'];
  }
}
