import 'new/courses_model.dart';

class AssignmentsModel {
  String? status;
  String? message;
  List<Assignment>? assignments;

  AssignmentsModel({this.status, this.message, this.assignments});

  AssignmentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['assignments'] != null) {
      assignments = <Assignment>[];
      json['assignments'].forEach((v) {
        assignments!.add(Assignment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.assignments != null) {
      data['assignments'] = this.assignments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Author {
  UserEducation? userEducation;
  String? sId;
  String? userName;
  String? email;
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
  List<String>? myTracks;

  Author(
      {this.userEducation,
        this.sId,
        this.userName,
        this.email,
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
        this.wishList,
        this.myTracks});

  Author.fromJson(Map<String, dynamic> json) {
    userEducation = json['userEducation'] != null
        ? UserEducation.fromJson(json['userEducation'])
        : null;
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
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
    myTracks = json['myTracks'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.userEducation != null) {
      data['userEducation'] = this.userEducation!.toJson();
    }
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
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
    data['myTracks'] = this.myTracks;
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