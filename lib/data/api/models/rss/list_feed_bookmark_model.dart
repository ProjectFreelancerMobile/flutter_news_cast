class ListFeedBookmarkModel {
  String url;
  int rssType;
  String? baseUrl;

  ListFeedBookmarkModel(this.url, this.rssType, {this.baseUrl});

  @override
  String toString() {
    return 'ListFeedBookmarkModel{url: $url, rssType: $rssType, baseUrl:$baseUrl}';
  }
}
