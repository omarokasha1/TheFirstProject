class assignmentsModel {
  String? status;
  String? message;
  List<Assignments>? assignments;

  assignmentsModel({this.status, this.message, this.assignments});

  assignmentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['assignments'] != null) {
      assignments = <Assignments>[];
      json['assignments'].forEach((v) {
        assignments!.add(new Assignments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.assignments != null) {
      data['assignments'] = this.assignments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assignments {
  String? sId;
  String? assignmentTitle;
  String? assignmentDuration;
  String? fileUrl;
  String? description;
  String? author;
  int? iV;

  Assignments(
      {this.sId,
        this.assignmentTitle,
        this.assignmentDuration,
        this.fileUrl,
        this.description,
        this.author,
        this.iV});

  Assignments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    assignmentTitle = json['assignmentTitle'];
    assignmentDuration = json['assignmentDuration'];
    fileUrl = json['fileUrl'];
    description = json['description'];
    author = json['author'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['assignmentTitle'] = this.assignmentTitle;
    data['assignmentDuration'] = this.assignmentDuration;
    data['fileUrl'] = this.fileUrl;
    data['description'] = this.description;
    data['author'] = this.author;
    data['__v'] = this.iV;
    return data;
  }
}