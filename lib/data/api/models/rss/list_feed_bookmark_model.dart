class ListFeedBookmarkModel {
  int id;
  String url;
  int rssType;
  String? baseUrl;

  ListFeedBookmarkModel(this.id, this.url, this.rssType, {this.baseUrl});

  @override
  String toString() {
    return 'ListFeedBookmarkModel{id:$id, url: $url, rssType: $rssType, baseUrl:$baseUrl}';
  }
}
