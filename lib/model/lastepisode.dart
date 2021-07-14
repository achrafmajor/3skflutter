class lastepisodemodel {
  final String Titel;
  final String date;
  final String view;
  final String episode;
  final String image;
  final String langue;
  const lastepisodemodel({this.Titel, this.date, this.view, this.episode, this.image, this.langue});

  factory lastepisodemodel.fromJson(Map<String, dynamic> json) {
    return lastepisodemodel(
      Titel: json['current_page'],
      date: json['id'],
      episode: json['title'],
      image: json['title'],
      langue: json['title'],

    );
  }
}