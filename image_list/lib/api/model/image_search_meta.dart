class ImageSearchMeta {
  int? totalCount;
  int? pageableCount;
  bool? isEnd;

  ImageSearchMeta({
    this.totalCount,
    this.pageableCount,
    this.isEnd,
  });

  ImageSearchMeta.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    pageableCount = json['pageable_count'];
    isEnd = json['is_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    data['pageable_count'] = pageableCount;
    data['is_end'] = isEnd;
    return data;
  }
}
