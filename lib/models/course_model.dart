//This Course Model to get Data From API
class CourseModel {
  String? sId;
  String? totalTime;
  String? lastUpdate;
  String? requiremnets;
  String? title;
  String? price;
  String? discount;
  String? language;
  String? description;
  String? review;
  String? imageUrl;
  Author? author;

  CourseModel(
      {this.sId,
        this.totalTime,
        this.lastUpdate,
        this.requiremnets,
        this.title,
        this.price,
        this.discount,
        this.language,
        this.description,
        this.review,
        this.imageUrl,
        this.author,});

  CourseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalTime = json['totalTime'];
    lastUpdate = json['lastUpdate'];
    requiremnets = json['requiremnets'];
    title = json['title'];
    price = json['price'];
    discount = json['discount'];
    language = json['language'];
    description = json['description'];
    review = json['review'];
    imageUrl = json['imageUrl'];
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['totalTime'] = this.totalTime;
    data['lastUpdate'] = this.lastUpdate;
    data['requiremnets'] = this.requiremnets;
    data['title'] = this.title;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['language'] = this.language;
    data['description'] = this.description;
    data['review'] = this.review;
    data['imageUrl'] = this.imageUrl;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    return data;
  }
}

//This To Fetch Auther Data From API
class Author {
  String? sId;
  String? userName;
  String? email;
  String? password;
  bool? isAdmin;
  String? phone;
  String? birthDay;
  String? city;
  String? country;
  String? gender;
  String? imageUrl;
  UserEducation? userEducation;
  String? bio;

  Author(
      {this.sId,
        this.userName,
        this.email,
        this.password,
        this.isAdmin,
        this.phone,
        this.birthDay,
        this.city,
        this.country,
        this.gender,
        this.imageUrl,
        this.userEducation,
        this.bio});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    isAdmin = json['isAdmin'];
    phone = json['phone'];
    birthDay = json['birthDay'];
    city = json['city'];
    country = json['country'];
    gender = json['gender'];
    imageUrl = json['imageUrl'];
    userEducation = json['userEducation'] != null
        ? new UserEducation.fromJson(json['userEducation'])
        : null;
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['isAdmin'] = this.isAdmin;
    data['phone'] = this.phone;
    data['birthDay'] = this.birthDay;
    data['city'] = this.city;
    data['country'] = this.country;
    data['gender'] = this.gender;
    data['imageUrl'] = this.imageUrl;
    if (this.userEducation != null) {
      data['userEducation'] = this.userEducation!.toJson();
    }
    data['bio'] = this.bio;
    return data;
  }
}

//This To Fetch User Educational Data From API
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