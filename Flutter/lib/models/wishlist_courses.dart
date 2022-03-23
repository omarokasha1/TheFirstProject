class WishlistCourses {
  String? status;
  String? message;
  List<WishList>? wishList = [];

  WishlistCourses({this.status, this.message, this.wishList});

  WishlistCourses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['wishList'] != null) {
      wishList = <WishList>[];
      json['wishList'].forEach((v) {
        wishList!.add(WishList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (wishList != null) {
      data['wishList'] = wishList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishList {
  String? sId;
  String? requirements;
  String? title;
  String? language;
  String? description;
  String? imageUrl;
  bool? isPublished;
  List<String>? contents;
  String? author;

  WishList(
      {this.sId,
        this.requirements,
        this.title,
        this.language,
        this.description,
        this.imageUrl,
        this.isPublished,
        this.contents,
        this.author,});

  WishList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    requirements = json['requirements'];
    title = json['title'];
    language = json['language'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    isPublished = json['isPublished'];
    contents = json['contents'].cast<String>();
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['requirements'] = requirements;
    data['title'] = title;
    data['language'] = language;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['isPublished'] = isPublished;
    data['contents'] = contents;
    data['author'] = author;
    return data;
  }
}