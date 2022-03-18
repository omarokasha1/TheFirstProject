class AuthorRequests {
  String? status;
  String? message;
  List<PromotRequests>? promotRequests =[];

  AuthorRequests({this.status, this.message, this.promotRequests});

  AuthorRequests.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['promotRequests'] != null) {
      promotRequests = <PromotRequests>[];
      json['promotRequests'].forEach((v) {
        promotRequests!.add(PromotRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.promotRequests != null) {
      data['promotRequests'] =
          this.promotRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromotRequests {
  String? sId;
  String? authorPromoted;

  PromotRequests({this.sId, this.authorPromoted});

  PromotRequests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    authorPromoted = json['authorPromoted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['authorPromoted'] = this.authorPromoted;
    return data;
  }
}