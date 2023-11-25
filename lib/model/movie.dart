class Movie {
  int? id;
  String? title;
  String? url;
  String? summary;
  String? imageMedium;
  String? imageOriginal;

  Movie(
      {this.id,
      this.title,
      this.url,
      this.summary,
      this.imageMedium,
      this.imageOriginal});

  Movie.fromJson(Map<String, dynamic> json) {
    var showObj = json['show'];
    var imageObj = showObj['image'];
    id = showObj['id'];
    title = showObj['name'];
    url = showObj['url'];
    summary = showObj['summary'];
    if (imageObj != null) {
      imageMedium = imageObj['medium'];
      imageOriginal = imageObj['original'];
    } else {
      imageMedium = null;
      imageOriginal = null;
    }
  }
}
