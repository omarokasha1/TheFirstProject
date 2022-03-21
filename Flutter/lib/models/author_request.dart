class AuthorRequests {
  String? status;
  String? message;
  List<PromotRequests>? promotRequests;

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
  AuthorPromoted? authorPromoted;

  PromotRequests({this.sId, this.authorPromoted});

  PromotRequests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    authorPromoted = json['authorPromoted'] != null
        ? AuthorPromoted.fromJson(json['authorPromoted'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.authorPromoted != null) {
      data['authorPromoted'] = this.authorPromoted!.toJson();
    }
    return data;
  }
}

class AuthorPromoted {
  String? sId;
  String? userName;
  String? email;
  String? phone;
  bool? isAdmin;
  bool? isAuthor;
  bool? isManager;
  String? imageUrl;

  AuthorPromoted(
      {
        this.sId,
        this.userName,
        this.email,
        this.phone,
        this.isAdmin,
        this.isAuthor,
        this.isManager,
        this.imageUrl,});

  AuthorPromoted.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    isAdmin = json['isAdmin'];
    isAuthor = json['isAuthor'];
    isManager = json['isManager'];
    imageUrl = json['imageUrl'];
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
    return data;
  }
}