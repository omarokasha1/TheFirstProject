class CoursesModel {
  String? status;
  String? message;
  List<Courses>? courses;

  CoursesModel({this.status, this.message, this.courses});

  CoursesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
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
  List<Author>? wishers;
  bool? isPublished;
  List<Contents>? contents;
  List<Assignment>? assignment;
  List<Author>? learner;
  Author? author;
  String? lastUpdate;
  String? review;

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
        this.assignment,
        this.learner,
        this.lastUpdate,
        this.review,
        this.author});

  Courses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    requirements = json['requirements'];
    title = json['title'];
    language = json['language'];
    lastUpdate = json['lastUpdate'];
    description = json['description'];
    review = json['review'];
    imageUrl = json['imageUrl'];
    if (json['wishers'] != null) {
      wishers = <Author>[];
      json['wishers'].forEach((v) {
        wishers!.add(Author.fromJson(v));
      });
    }
    isPublished = json['isPublished'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
    if (json['assignments'] != null) {
      assignment = <Assignment>[];
      json['assignments'].forEach((v) {
        assignment!.add(Assignment.fromJson(v));
      });
    }
    if (json['learner'] != null) {
      learner = <Author>[];
      json['learner'].forEach((v) {
        learner!.add(Author.fromJson(v));
      });
    }
    author =
    json['author'] != null ? Author.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['requirements'] = requirements;
    data['title'] = title;
    data['language'] = language;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    if (wishers != null) {
      data['wishers'] = wishers!.map((v) => v.toJson()).toList();
    }
    data['isPublished'] = isPublished;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    if (learner != null) {
      data['learner'] = learner!.map((v) => v.toJson()).toList();
    }
    if (author != null) {
      data['author'] = author!.toJson();
    }
    return data;
  }
}

class   Author {
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
  String? imageUrl;
  String? bio;
  String? birthDay;
  String? city;
  String? country;
  String? gender;

  Author(
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
        this.imageUrl,
        this.bio,
        this.birthDay,
        this.city,
        this.country,
        this.gender});

  Author.fromJson(Map<String, dynamic> json) {
    userEducation = json['userEducation'] != null
        ? UserEducation.fromJson(json['userEducation'])
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
    imageUrl = json['imageUrl'];
    bio = json['bio'];
    birthDay = json['birthDay'];
    city = json['city'];
    country = json['country'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userEducation != null) {
      data['userEducation'] = userEducation!.toJson();
    }
    data['myTracks'] = myTracks;
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    data['phone'] = phone;
    data['isAdmin'] = isAdmin;
    data['isAuthor'] = isAuthor;
    data['isManager'] = isManager;
    data['wishList'] = wishList;
    data['myCourses'] = myCourses;
    data['imageUrl'] = imageUrl;
    data['bio'] = bio;
    data['birthDay'] = birthDay;
    data['city'] = city;
    data['country'] = country;
    data['gender'] = gender;
    return data;
  }
}

class UserEducation {
  List<String>? interest;
  String? major;
  String? university;
  String? faculty;
  String? experince;
  String? grade;

  UserEducation(
      {this.interest,
        this.major,
        this.university,
        this.faculty,
        this.experince,
        this.grade});

  UserEducation.fromJson(Map<String, dynamic> json) {
    interest = json['interest'].cast<String>();
    major = json['major'];
    university = json['university'];
    faculty = json['faculty'];
    experince = json['experince'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['interest'] = interest;
    data['major'] = major;
    data['university'] = university;
    data['faculty'] = faculty;
    data['experince'] = experince;
    data['grade'] = grade;
    return data;
  }
}

class Contents {
  bool? isFinished;
  String? sId;
  String? contentTitle;
  String? contentDuration;
  String? imageUrl;
  String? description;
  String? author;
  //List<Null>? courses;

  Contents(
      {this.isFinished,
        this.sId,
        this.contentTitle,
        this.contentDuration,
        this.imageUrl,
        this.description,
        this.author,
        //this.courses
      });

  Contents.fromJson(Map<String, dynamic> json) {
    isFinished = json['isFinished'];
    sId = json['_id'];
    contentTitle = json['contentTitle'];
    contentDuration = json['contentDuration'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    author = json['author'];
    // if (json['courses'] != null) {
    //   courses = <Null>[];
    //   json['courses'].forEach((v) {
    //     courses!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFinished'] = isFinished;
    data['_id'] = sId;
    data['contentTitle'] = contentTitle;
    data['contentDuration'] = contentDuration;
    data['imageUrl'] = imageUrl;
    data['description'] = description;
    data['author'] = author;
    // if (courses != null) {
    //   data['courses'] = courses!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
class Assignment {
  String? sId;
  String? assignmentTitle;
  String? assignmentDuration;
  String? fileUrl;
  String? description;
  //String? author;

  Assignment(
      {this.sId,
        this.assignmentTitle,
        this.assignmentDuration,
        this.fileUrl,
        this.description,
        //this.author
      });

  Assignment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    assignmentTitle = json['assignmentTitle'];
    assignmentDuration = json['assignmentDuration'];
    fileUrl = json['fileUrl'];
    description = json['description'];
    //author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['assignmentTitle'] = this.assignmentTitle;
    data['assignmentDuration'] = this.assignmentDuration;
    data['fileUrl'] = this.fileUrl;
    data['description'] = this.description;
    //data['author'] = this.author;
    return data;
  }
}