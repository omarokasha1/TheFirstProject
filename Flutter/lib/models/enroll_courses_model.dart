class enrollCoursesModel {
  String? status;
  String? message;
  List<MyCourses>? myCourses;

  enrollCoursesModel({this.status, this.message, this.myCourses});

  enrollCoursesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['myCourses'] != null) {
      myCourses = <MyCourses>[];
      json['myCourses'].forEach((v) {
        myCourses!.add(new MyCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.myCourses != null) {
      data['myCourses'] = this.myCourses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyCourses {
  String? sId;
  String? requirements;
  String? title;
  String? language;
  String? description;
  String? imageUrl;
  List<String>? wishers;
  bool? isPublished;
  List<String>? contents;
  List<String>? learner;
  String? author;
  int? iV;

  MyCourses(
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
        this.author,
        this.iV});

  MyCourses.fromJson(Map<String, dynamic> json) {
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
    contents = json['contents'].cast<String>();
    if (json['learner'] != null) {
      learner = <String>[];
      json['learner'].forEach((v) {
        learner!.add(v);
      });
    }
    author = json['author'];
    iV = json['__v'];
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
    data['contents'] = this.contents;
    if (this.learner != null) {
      data['learner'] = this.learner!.toList();
    }
    data['author'] = this.author;
    data['__v'] = this.iV;
    return data;
  }
}