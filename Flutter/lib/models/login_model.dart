// This Login Model To Fetch Data From API
class LoginModel {
  String? status = "";
  String? message="";
  String? token = "";
  bool? isAdmin = false;
  bool? isManager = false;
  bool? isAuthor = false;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'] ?? null;
    isAdmin = json['isAdmin'];
    isManager = json['isManager'];
    isAuthor = json['isAuthor'];
  }
}