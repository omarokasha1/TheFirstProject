class AuthorRequests {
  String? status;
  String? message;
  List<PromotRequests>? promotRequests = [];

  AuthorRequests({this.status, this.message, this.promotRequests});

  AuthorRequests.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    json['promotRequests'].forEach((v) {
      promotRequests!.add(PromotRequests.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (promotRequests != null) {
      data['promotRequests'] =
          promotRequests!.map((v) => v.toJson()).toList();
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
    data['_id'] = sId;
    if (authorPromoted != null) {
      data['authorPromoted'] = authorPromoted!.toJson();
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

  AuthorPromoted({
    this.sId,
    this.userName,
    this.email,
    this.phone,
    this.isAdmin,
    this.isAuthor,
    this.isManager,
    this.imageUrl,
  });

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
    data['_id'] = sId;
    data['userName'] = userName;
    data['email'] = email;
    data['phone'] = phone;
    data['isAdmin'] = isAdmin;
    data['isAuthor'] = isAuthor;
    data['isManager'] = isManager;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
