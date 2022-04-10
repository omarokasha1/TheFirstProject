class AuthorsManagerRequest {
  String? status;
  String? message;
  List<Users>? users = [];

  AuthorsManagerRequest({this.status, this.message, this.users});

  AuthorsManagerRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? sId;
  String? userName;
  String? email;
  String? phone;
  bool? isAdmin;
  bool? isAuthor;
  bool? isManager;
  String? imageUrl;
  String? gender;
  String? bio;
  String? birthDay;

  Users(
      {
        this.sId,
        this.userName,
        this.email,
        this.phone,
        this.isAdmin,
        this.isAuthor,
        this.isManager,
        this.imageUrl,
        this.gender,
        this.bio,
        this.birthDay,});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    isAdmin = json['isAdmin'];
    isAuthor = json['isAuthor'];
    isManager = json['isManager'];
    imageUrl = json['imageUrl'];
    gender = json['gender'];
    bio = json['bio'];
    birthDay = json['birthDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['isAdmin'] = this.isAdmin;
    data['isAuthor'] = this.isAuthor;
    data['isManager'] = this.isManager;
    data['imageUrl'] = this.imageUrl;
    data['gender'] = this.gender;
    data['bio'] = this.bio;
    data['birthDay'] = this.birthDay;
    return data;
  }
}