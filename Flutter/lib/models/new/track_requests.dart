class TrackRequestsModel {
  String? status;
  String? message;
  List<TrackRequests>? trackRequests = [];

  TrackRequestsModel({this.status, this.message, this.trackRequests});

  TrackRequestsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['trackRequests'] != null) {
      trackRequests = <TrackRequests>[];
      json['trackRequests'].forEach((v) {
        trackRequests!.add(TrackRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.trackRequests != null) {
      data['trackRequests'] =
          this.trackRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrackRequests {
  String? sId;
  AuthorId? authorId;
  TrackId? trackId;

  TrackRequests({this.sId, this.authorId, this.trackId});

  TrackRequests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    authorId = json['authorId'] != null
        ? AuthorId.fromJson(json['authorId'])
        : null;
    trackId =
    json['trackId'] != null ? TrackId.fromJson(json['trackId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.authorId != null) {
      data['authorId'] = this.authorId!.toJson();
    }
    if (this.trackId != null) {
      data['trackId'] = this.trackId!.toJson();
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
    gender = json['gender'];
    imageUrl = json['imageUrl'];
    bio = json['bio'];
    birthDay = json['birthDay'];
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class TrackId {
  List<Null>? wishers;
  String? sId;
  String? trackName;
  String? description;
  String? imageUrl;
  String? check;
  bool? isPublished;
  String? author;
  List<String>? courses;

  TrackId(
      {this.wishers,
        this.sId,
        this.trackName,
        this.description,
        this.imageUrl,
        this.check,
        this.isPublished,
        this.author,
        this.courses});

  TrackId.fromJson(Map<String, dynamic> json) {
    if (json['wishers'] != null) {
      wishers = <Null>[];
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
    author = json['author'];
    courses = json['courses'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.wishers != null) {
      data['wishers'] = this.wishers!.toList();
    }
    data['_id'] = this.sId;
    data['trackName'] = this.trackName;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['check'] = this.check;
    data['isPublished'] = this.isPublished;
    data['author'] = this.author;
    data['courses'] = this.courses;
    return data;
  }
}