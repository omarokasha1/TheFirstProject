//This Register Model To Fetch Data from API
class RegisterModel {
  String? status;
  String? message;
  String? id;
  String? userName;
  String? email;
  String? phone;
  String? token;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
    status = json['status'];
    message = json['message'];
  }
}