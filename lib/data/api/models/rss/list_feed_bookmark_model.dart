class ListFeedBookmarkModel {
  int id;
  String url;
  String? title = '';
  int rssType;
  String? baseUrl;

  ListFeedBookmarkModel(this.id, this.url, this.rssType, {this.title, this.baseUrl});

  @override
  String toString() {
    return 'ListFeedBookmarkModel{id:$id, title:$title, url: $url, rssType: $rssType, baseUrl:$baseUrl}';
  }
}
