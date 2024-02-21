import 'package:image_list/api/model/image_search_document.dart';
import 'package:image_list/api/model/image_search_meta.dart';

class ImageSearchResponse {
  ImageSearchMeta? meta;
  List<ImageSearchDocument>? documents;

  ImageSearchResponse({
    this.meta,
    this.documents,
  });

  ImageSearchResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? ImageSearchMeta.fromJson(json['meta']) : null;
    if (json['documents'] != null) {
      documents = <ImageSearchDocument>[];
      json['documents'].forEach((v) {
        documents!.add(ImageSearchDocument.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
