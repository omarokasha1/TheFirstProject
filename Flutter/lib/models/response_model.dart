class ResponseModel {
  String? status;
  String? message;

  ResponseModel({this.status, this.message});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

}