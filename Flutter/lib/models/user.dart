//This User Model To Fetch Data From API
class User {
  Profile? profile;

  User({this.profile});

  User.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

//This Profile Model To Fetch Data From API
class Profile {
  String? sId ="";
  String? userName = "";
  String? email = '';
  String? phone = '';
  String? birthDay = '';
  String? city = '';
  String? country = '';
  String? gender = '';
  String? imageUrl = '';
  UserEducation? userEducation;
  String? bio = '';
  bool? isAdmin = false;
  bool? isManager = false;
  bool? isAuthor = false;
  List<String>? myCourses = [];
  List<String>? wishList = [];
  List<String>? myTracks = [];

  Profile(
      {this.sId,
        this.userName,
        this.email,
        this.phone,
        this.birthDay,
        this.city,
        this.country,
        this.gender,
        this.imageUrl,
        this.userEducation,
        this.bio,
        this.isAdmin,
        this.isAuthor,
        this.isManager,
        this.myCourses,
        this.wishList,
        this.myTracks,
      });

  Profile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    userName = json['userName'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    birthDay = json['birthDay'] ?? '';
    city = json['city'] ?? '';
    country = json['country'] ?? '';
    gender = json['gender'] ?? 'Male';
    imageUrl = json['imageUrl'] ?? '';
    userEducation = json['userEducation'] != null
        ? UserEducation.fromJson(json['userEducation'])
        : UserEducation();
    //myCourses = json['myCourses'] != null ? MyCourses.fromJson(json['myCourses']):MyCourses();
    bio = json['bio'] ?? '';
    isAdmin = json['isAdmin'] ;
    isAuthor = json['isAuthor'] ;
    isManager = json['isManager'] ;
    myCourses = json['myCourses'].cast<String>() ?? '' ;
    wishList = json['wishList'].cast<String>() ?? '' ;
    myTracks = json['myTracks'].cast<String>() ?? '' ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
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
    data['isAdmin'] = this.isAdmin;
    data['isAuthor'] = this.isAuthor;
    data['isManager'] = this.isManager;
    return data;
  }
}
// class MyCourses{
//   List<String>? myCourses = [];
//   MyCourses({this.myCourses});
//   MyCourses.fromJson(Map<String, dynamic> json){
//     myCourses = json['myCourses'].cast<String>() ?? '';
//   }
// }
//This User Education Model To Fetch Data From API
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