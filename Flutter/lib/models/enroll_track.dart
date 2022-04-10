class EnrollTracks {
  String? status;
  String? message;
  List<MyTracks>? myTracks;

  EnrollTracks({this.status, this.message, this.myTracks});

  EnrollTracks.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['myTracks'] != null) {
      myTracks = <MyTracks>[];
      json['myTracks'].forEach((v) {
        myTracks!.add(MyTracks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (myTracks != null) {
      data['myTracks'] = myTracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyTracks {
  List<String>? wishers;
  String? sId;
  String? trackName;
  String? description;
  String? imageUrl;
  String? check;
  bool? isPublished;
  Author? author;
  List<Courses>? courses;
  Learner? learner;

  MyTracks(
      {this.wishers,
        this.sId,
        this.trackName,
        this.description,
        this.imageUrl,
        this.check,
        this.isPublished,
        this.author,
        this.courses,
        this.learner});

  MyTracks.fromJson(Map<String, dynamic> json) {
    if (json['wishers'] != null) {
      wishers = <String>[];
      json['wishers'].forEach((v) {
        wishers!.add(v);
      });
    }
    sId = json['_id'];
    trackName = json['trackName'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    check = json['check'];
    isPublished = json['isPublished'];
    author =
    json['author'] != null ? Author.fromJson(json['author']) : null;
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
    learner =
    json['learner'] != null ? Learner.fromJson(json['learner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['trackName'] = trackName;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['check'] = check;
    data['isPublished'] = isPublished;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    if (learner != null) {
      data['learner'] = learner!.toJson();
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

}

class Courses {
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

  Courses(
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

  Courses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    requirements = json['requirements'];
    title = json['title'];
    language = json['language'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    wishers = json['wishers'].cast<String>();
    isPublished = json['isPublished'];
    contents = json['contents'].cast<String>();
    learner = json['learner'].cast<String>();
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['requirements'] = requirements;
    data['title'] = title;
    data['language'] = language;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['wishers'] = wishers;
    data['isPublished'] = isPublished;
    data['contents'] = contents;
    data['learner'] = learner;
    data['author'] = author;
    return data;
  }
}

class Learner {
  UserEducation? userEducation;
  String? gender;
  String? imageUrl;
  String? sId;
  String? userName;
  String? email;
  String? phone;
  bool? isAdmin;
  bool? isAuthor;
  bool? isManager;
  List<String>? wishList;
  List<String>? myCourses;
  List<String>? myTracks;

  Learner(
      {this.userEducation,
        this.gender,
        this.imageUrl,
        this.sId,
        this.userName,
        this.email,
        this.phone,
        this.isAdmin,
        this.isAuthor,
        this.isManager,
        this.wishList,
        this.myCourses,
        this.myTracks});

  Learner.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    imageUrl = json['imageUrl'];
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    isAdmin = json['isAdmin'];
    isAuthor = json['isAuthor'];
    isManager = json['isManager'];
    wishList = json['wishList'].cast<String>();
    myCourses = json['myCourses'].cast<String>();
    myTracks = json['myTracks'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['gender'] = gender;
    data['imageUrl'] = imageUrl;
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    data['phone'] = phone;
    data['isAdmin'] = isAdmin;
    data['isAuthor'] = isAuthor;
    data['isManager'] = isManager;
    data['wishList'] = wishList;
    data['myCourses'] = myCourses;
    data['myTracks'] = myTracks;
    return data;
  }
}