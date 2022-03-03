// class TrackModel {
//   String? status = '';
//   List<Tracks>? tracks = [];
//
//   TrackModel({this.status, this.tracks});
//
//   TrackModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['tracks'] != null) {
//       tracks = <Tracks>[];
//       json['tracks'].forEach((v) {
//         tracks!.add(new Tracks.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.tracks != null) {
//       data['tracks'] = this.tracks!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Tracks {
//   String? sId;
//   String? trackName;
//   String? description;
//   String? imageUrl;
//   String? author;
//   List<String>? courses;
//
//   Tracks({
//     this.sId,
//     this.trackName,
//     this.description,
//     this.imageUrl,
//     this.author,
//     this.courses,
//   });
//
//   Tracks.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     trackName = json['trackName'];
//     description = json['description'];
//     imageUrl = json['imageUrl'];
//     author = json['author'];
//     courses = json['courses'].cast<String>();
//   }
//// class TrackModel {
//   String? status = '';
//   List<Tracks>? tracks = [];
//
//   TrackModel({this.status, this.tracks});
//
//   TrackModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['tracks'] != null) {
//       tracks = <Tracks>[];
//       json['tracks'].forEach((v) {
//         tracks!.add(new Tracks.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.tracks != null) {
//       data['tracks'] = this.tracks!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Tracks {
//   String? sId;
//   String? trackName;
//   String? description;
//   String? imageUrl;
//   String? author;
//   List<String>? courses;
//
//   Tracks({
//     this.sId,
//     this.trackName,
//     this.description,
//     this.imageUrl,
//     this.author,
//     this.courses,
//   });
//
//   Tracks.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     trackName = json['trackName'];
//     description = json['description'];
//     imageUrl = json['imageUrl'];
//     author = json['author'];
//     courses = json['courses'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['trackName'] = this.trackName;
//     data['description'] = this.description;
//     data['imageUrl'] = this.imageUrl;
//     data['author'] = this.author;
//     data['courses'] = this.courses;
//     return data;
//   }
// }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['trackName'] = this.trackName;
//     data['description'] = this.description;
//     data['imageUrl'] = this.imageUrl;
//     data['author'] = this.author;
//     data['courses'] = this.courses;
//     return data;
//   }
// }

class TrackModel {
  String? status;
  String? message;
  List<Tracks>? tracks;

  TrackModel({this.status, this.message, this.tracks});

  TrackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['tracks'] != null) {
      tracks = <Tracks>[];
      json['tracks'].forEach((v) {
        tracks!.add(new Tracks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.tracks != null) {
      data['tracks'] = this.tracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tracks {
  String? sId;
  String? trackName;
  String? description;
  String? imageUrl;
  String? check;
  bool? isPublished;
  String? author;
  List<Courses>? courses;

  Tracks(
      {this.sId,
        this.trackName,
        this.description,
        this.imageUrl,
        this.check,
        this.isPublished,
        this.author,
        this.courses});

  Tracks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    trackName = json['trackName'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    check = json['check'];
    isPublished = json['isPublished'];
    author = json['author'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['trackName'] = this.trackName;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['check'] = this.check;
    data['isPublished'] = this.isPublished;
    data['author'] = this.author;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  String? sId;
  String? requirements;
  String? title;
  String? language;
  String? description;
  String? imageUrl;
  bool? isPublished;
  List<String>? contents;
  String? author;

  Courses(
      {this.sId,
        this.requirements,
        this.title,
        this.language,
        this.description,
        this.imageUrl,
        this.isPublished,
        this.contents,
        this.author});

  Courses.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['requirements'] = this.requirements;
    data['title'] = this.title;
    data['language'] = this.language;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['isPublished'] = this.isPublished;
    data['contents'] = this.contents;
    data['author'] = this.author;
    return data;
  }
}