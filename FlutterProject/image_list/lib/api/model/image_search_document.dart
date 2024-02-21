class ImageSearchDocument {
  String? collection;
  String? thumbnailUrl;
  String? imageUrl;
  int? width;
  int? height;
  String? displaySitename;
  String? docUrl;
  String? datetime;
  bool? isFavorite;

  ImageSearchDocument({
    this.collection,
    this.thumbnailUrl,
    this.imageUrl,
    this.width,
    this.height,
    this.displaySitename,
    this.docUrl,
    this.datetime,
    this.isFavorite = false,
  });

  ImageSearchDocument.fromJson(Map<String, dynamic> json) {
    collection = json['collection'];
    thumbnailUrl = json['thumbnail_url'];
    imageUrl = json['image_url'];
    width = json['width'];
    height = json['height'];
    displaySitename = json['display_sitename'];
    docUrl = json['doc_url'];
    datetime = json['datetime'];
    isFavorite = json['isFavorite'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = collection;
    data['thumbnail_url'] = thumbnailUrl;
    data['image_url'] = imageUrl;
    data['width'] = width;
    data['height'] = height;
    data['display_sitename'] = displaySitename;
    data['doc_url'] = docUrl;
    data['datetime'] = datetime;
    data['isFavorite'] = isFavorite;
    return data;
  }
}
