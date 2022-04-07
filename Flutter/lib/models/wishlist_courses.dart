// import 'package:lms/models/new/courses_model.dart';
//
// class WishlistCourses {
//   String? status;
//   String? message;
//   List<Courses>? wishList = [];
//
//   WishlistCourses({this.status, this.message, this.wishList});
//
//   WishlistCourses.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['wishList'] != null) {
//       wishList = <Courses>[];
//       json['wishList'].forEach((v) {
//         wishList!.add(Courses.fromJson(v));
//       });
//     }
//   }
// }

class WishlistCourses {
  String? status;
  String? message;
  List<WishList>? wishList;

  WishlistCourses({this.status, this.message, this.wishList});

  WishlistCourses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['wishList'] != null) {
      wishList = <WishList>[];
      json['wishList'].forEach((v) { wishList!.add(WishList.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (wishList != null) {
      data['wishList'] = wishList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishList {
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
  Author? author;

  WishList({this.sId, this.requirements, this.title, this.language, this.description, this.imageUrl, this.wishers, this.isPublished, this.contents, this.learner, this.author});

  WishList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    requirements = json['requirements'];
    title = json['title'];
    language = json['language'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    wishers = json['wishers'].cast<String>();
    isPublished = json['isPublished'];
    if (json['contents'] != null) {
      contents = json['contents'].cast<String>();
    }
    learner = json['learner'].cast<String>();
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['requirements'] = this.requirements;
    data['title'] = this.title;
    data['language'] = this.language;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['wishers'] = this.wishers;
    data['isPublished'] = this.isPublished;
    data['learner'] = this.learner;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
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

  Author({this.userEducation, this.sId, this.userName, this.email, this.phone, this.myCourses, this.isAdmin, this.isAuthor, this.bio, this.birthDay, this.city, this.country, this.gender, this.imageUrl, this.isManager, this.wishList, this.myTracks});

  Author.fromJson(Map<String, dynamic> json) {
    userEducation = json['userEducation'] != null ? UserEducation.fromJson(json['userEducation']) : null;
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
    if (userEducation != null) {
      data['userEducation'] = userEducation!.toJson();
    }
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    data['phone'] = phone;
    data['myCourses'] = myCourses;
    data['isAdmin'] = isAdmin;
    data['isAuthor'] = isAuthor;
    data['bio'] = bio;
    data['birthDay'] = birthDay;
    data['city'] = city;
    data['country'] = country;
    data['gender'] = gender;
    data['imageUrl'] = imageUrl;
    data['isManager'] = isManager;
    data['wishList'] = wishList;
    data['myTracks'] = myTracks;
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

  UserEducation({this.university, this.major, this.faculty, this.grade, this.experince, this.interest});

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
    data['university'] = university;
    data['major'] = major;
    data['faculty'] = faculty;
    data['grade'] = grade;
    data['experince'] = experince;
    data['interest'] = interest;
    return data;
  }
}