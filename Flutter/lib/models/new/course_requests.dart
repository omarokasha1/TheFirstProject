class CoursesRequests {
  String? status;
  String? message;
  List<CourseRequests>? courseRequests;

  CoursesRequests({this.status, this.message, this.courseRequests});

  CoursesRequests.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['courseRequests'] != null) {
      courseRequests = <CourseRequests>[];
      json['courseRequests'].forEach((v) {
        courseRequests!.add(new CourseRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.courseRequests != null) {
      data['courseRequests'] =
          this.courseRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseRequests {
  String? sId;
  List<AuthorId>? authorId;
  List<CourseId>? courseId;

  CourseRequests({this.sId,  this.authorId, this.courseId});

  CourseRequests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['authorId'] != null) {
      authorId = <AuthorId>[];
      json['wishers'].forEach((v) {
        authorId!.add(AuthorId.fromJson(v));
      });
    }
    if (json['courseId'] != null) {
      courseId = <CourseId>[];
      json['wishers'].forEach((v) {
        courseId!.add(CourseId.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;

    if (authorId != null) {
      data['authorId'] = authorId!.map((v) => v.toJson()).toList();
    }
    if (courseId != null) {
      data['courseId'] = courseId!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class AuthorId {
  UserEducation? userEducation;
  List<String>? myTracks;
  String? sId;
  String? userName;
  String? email;
  String? phone;
  bool? isAdmin;
  bool? isAuthor;
  bool? isManager;
  List<String>? wishList;
  List<String>? myCourses;
  String? gender;
  String? imageUrl;
  String? bio;
  String? birthDay;
  String? city;
  String? country;

  AuthorId(
      {this.userEducation,
        this.myTracks,
        this.sId,
        this.userName,
        this.email,
        this.phone,
        this.isAdmin,
        this.isAuthor,
        this.isManager,
        this.wishList,
        this.myCourses,
        this.gender,
        this.imageUrl,
        this.bio,
        this.birthDay,
        this.city,
        this.country});

  AuthorId.fromJson(Map<String, dynamic> json) {
    userEducation = json['userEducation'] != null
        ? new UserEducation.fromJson(json['userEducation'])
        : null;
    myTracks = json['myTracks'].cast<String>();
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    isAdmin = json['isAdmin'];
    isAuthor = json['isAuthor'];
    isManager = json['isManager'];
    wishList = json['wishList'].cast<String>();
    myCourses = json['myCourses'].cast<String>();
    gender = json['gender'];
    imageUrl = json['imageUrl'];
    bio = json['bio'];
    birthDay = json['birthDay'];
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userEducation != null) {
      data['userEducation'] = this.userEducation!.toJson();
    }
    data['myTracks'] = this.myTracks;
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['isAdmin'] = this.isAdmin;
    data['isAuthor'] = this.isAuthor;
    data['isManager'] = this.isManager;
    data['wishList'] = this.wishList;
    data['myCourses'] = this.myCourses;
    data['gender'] = this.gender;
    data['imageUrl'] = this.imageUrl;
    data['bio'] = this.bio;
    data['birthDay'] = this.birthDay;
    data['city'] = this.city;
    data['country'] = this.country;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['university'] = this.university;
    data['major'] = this.major;
    data['faculty'] = this.faculty;
    data['grade'] = this.grade;
    data['experince'] = this.experince;
    data['interest'] = this.interest;
    return data;
  }
}

class CourseId {
  String? sId;
  String? requirements;
  String? title;
  String? language;
  String? description;
  String? imageUrl;
  List<Null>? wishers;
  bool? isPublished;
  List<String>? contents;
  List<Null>? learner;
  String? author;

  CourseId(
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

  CourseId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    requirements = json['requirements'];
    title = json['title'];
    language = json['language'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    if (json['wishers'] != null) {
      wishers = <Null>[];
      json['wishers'].forEach((v) {
        wishers!.add(v);
      });
    }
    isPublished = json['isPublished'];
    contents = json['contents'].cast<String>();
    if (json['learner'] != null) {
      learner = <Null>[];
      json['learner'].forEach((v) {
        learner!.add(v);
      });
    }
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['requirements'] = requirements;
    data['title'] = title;
    data['language'] = language;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    if (wishers != null) {
      data['wishers'] = wishers!.toList();
    }
    data['isPublished'] = isPublished;
    data['contents'] = contents;
    if (learner != null) {
      data['learner'] = learner!.toList();
    }
    data['author'] = author;
    return data;
  }
}