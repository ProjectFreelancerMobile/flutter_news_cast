class ListFeedBookmarkModel {
  String url;
  int rssType;

  ListFeedBookmarkModel(this.url, this.rssType);

  @override
  String toString() {
    return 'ListFeedBookmarkModel{url: $url, rssType: $rssType}';
  }
}
