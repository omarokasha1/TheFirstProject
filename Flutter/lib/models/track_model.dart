import 'package:lms/models/new/courses_model.dart';

class TrackModel {
  String? status;
  String? message;
  List<Tracks>? tracks;

  TrackModel({this.status, this.message, this.tracks});

  TrackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['tracks'] != null) {
      tracks = <Tracks>[];
      json['tracks'].forEach((v) {
        tracks!.add(Tracks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.tracks != null) {
      data['tracks'] = this.tracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tracks {
  String? sId;
  String? trackName;
  String? description;
  String? imageUrl;
  String? check;
  bool? isPublished;
  Author? author;
  List<Courses>? courses;

  Tracks(
      {this.sId,
        this.trackName,
        this.description,
        this.imageUrl,
        this.check,
        this.isPublished,
        this.author,
        this.courses});

  Tracks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    trackName = json['trackName'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    check = json['check'];
    isPublished = json['isPublished'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['trackName'] = this.trackName;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['check'] = this.check;
    data['isPublished'] = this.isPublished;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Author {
  UserEducation? userEducation;
  String? sId;
  String? userName;
  String? email;
  String? password;
  String? phone;
  List<String>? myCourses;
  bool? isAdmin;
  bool? isAuthor;
  String? bio;
  String? birthDay;
  String? city;
  String? country;
  String? gender;
  String? imageUrl;
  bool? isManager;
  List<String>? wishList;

  Author(
      {this.userEducation,
        this.sId,
        this.userName,
        this.email,
        this.password,
        this.phone,
        this.myCourses,
        this.isAdmin,
        this.isAuthor,
        this.bio,
        this.birthDay,
        this.city,
        this.country,
        this.gender,
        this.imageUrl,
        this.isManager,
        this.wishList});

  Author.fromJson(Map<String, dynamic> json) {
    userEducation = json['userEducation'] != null
        ? UserEducation.fromJson(json['userEducation'])
        : null;
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    myCourses = json['myCourses'].cast<String>();
    isAdmin = json['isAdmin'];
    isAuthor = json['isAuthor'];
    bio = json['bio'];
    birthDay = json['birthDay'];
    city = json['city'];
    country = json['country'];
    gender = json['gender'];
    imageUrl = json['imageUrl'];
    isManager = json['isManager'];
    wishList = json['wishList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.userEducation != null) {
      data['userEducation'] = this.userEducation!.toJson();
    }
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['myCourses'] = this.myCourses;
    data['isAdmin'] = this.isAdmin;
    data['isAuthor'] = this.isAuthor;
    data['bio'] = this.bio;
    data['birthDay'] = this.birthDay;
    data['city'] = this.city;
    data['country'] = this.country;
    data['gender'] = this.gender;
    data['imageUrl'] = this.imageUrl;
    data['isManager'] = this.isManager;
    data['wishList'] = this.wishList;
    return data;
  }
}

class UserEducation {
  String? university;
  String? major;
  String? faculty;
  String? grade;
  String? experince;
  List<String>? interest;

  UserEducation(
      {this.university,
        this.major,
        this.faculty,
        this.grade,
        this.experince,
        this.interest});

  UserEducation.fromJson(Map<String, dynamic> json) {
    university = json['university'];
    major = json['major'];
    faculty = json['faculty'];
    grade = json['grade'];
    experince = json['experince'];
    interest = json['interest'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['university'] = this.university;
    data['major'] = this.major;
    data['faculty'] = this.faculty;
    data['grade'] = this.grade;
    data['experince'] = this.experince;
    data['interest'] = this.interest;
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
  List<String>? contents;
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
    contents = json['contents'].cast<String>();
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
    data['contents'] = this.contents;
    data['author'] = this.author;
    return data;
  }
}