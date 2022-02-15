// This Login Model To Fetch Data From API
class LoginModel {
  String? status = "";
  String? message="";
  String? token = "";

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'] ?? null;
  }
}