class TrackModel {
  String? status;
  List<Tracks>? tracks;

  TrackModel({this.status, this.tracks});

  TrackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
  String? duration;
  String? imageUrl;
  String? author;
  List<String>? courses;

  Tracks(
      {this.sId,
      this.trackName,
      this.description,
      this.duration,
      this.imageUrl,
      this.author,
      this.courses,
      });

  Tracks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    trackName = json['trackName'];
    description = json['description'];
    duration = json['duration'];
    imageUrl = json['imageUrl'];
    author = json['author'];
    courses = json['courses'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['trackName'] = this.trackName;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['imageUrl'] = this.imageUrl;
    data['author'] = this.author;
    data['courses'] = this.courses;
    return data;
  }
}
