class QuizModel {
  String? status;
  String? message;
  List<Quizes>? quizes;

  QuizModel({this.status, this.message, this.quizes});

  QuizModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['quizes'] != null) {
      quizes = <Quizes>[];
      json['quizes'].forEach((v) {
        quizes!.add( Quizes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (quizes != null) {
      data['quizes'] = quizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quizes {
  String? sId;
  String? quizName;
  List<Questions>? questions;
  Author? author;
  List<Courses>? courses;

  Quizes({this.sId, this.quizName, this.questions, this.author, this.courses});

  Quizes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quizName = json['quizName'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add( Questions.fromJson(v));
      });
    }
    author =
    json['author'] != null ?  Author.fromJson(json['author']) : null;
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add( Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['quizName'] = quizName;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? sId;
  String? questionTitle;
  int? answerIndex;
  List<String>? options;
  String? author;
  List<Courses>? courses;

  Questions(
      {this.sId,
        this.questionTitle,
        this.answerIndex,
        this.options,
        this.author,
        this.courses});

  Questions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    questionTitle = json['questionTitle'];
    answerIndex = json['answerIndex'];
    options = json['options'].cast<String>();
    author = json['author'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add( Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['questionTitle'] = questionTitle;
    data['answerIndex'] = answerIndex;
    data['options'] = options;
    data['author'] = author;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Author {
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

  Author(
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

  Author.fromJson(Map<String, dynamic> json) {
    userEducation = json['userEducation'] != null
        ?  UserEducation.fromJson(json['userEducation'])
        : null;
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (userEducation != null) {
      data['userEducation'] = userEducation!.toJson();
    }
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

class UserEducation {
  String? university;
  String? major;
  String? faculty;
  String? grade;
  String? experince;
  List<String>? interest = [];

  UserEducation(
      {this.university,
        this.major,
        this.faculty,
        this.grade,
        this.experince,
        this.interest});

  UserEducation.fromJson(Map<String, dynamic> json) {
    university = json['university'] ?? '';
    major = json['major'] ?? '';
    faculty = json['faculty'] ?? '';
    grade = json['grade'] ?? '';
    experince = json['experince'] ?? '';
    interest = json['interest'].cast<String>() ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['university'] = university;
    data['major'] = major;
    data['faculty'] = faculty;
    data['grade'] = grade;
    data['experince'] = experince;
    data['interest'] = interest;
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
    final Map<String, dynamic> data =  <String, dynamic>{};
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
