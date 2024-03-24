import '../../../storage/key_constant.dart';

class ListFeedBookmarkModel {
  int id;
  RSS_TITLE type;
  String url;
  String? title = '';
  int rssType;
  String? baseUrl;
  String? icon;
  ListFeedBookmarkModel(this.id, this.url, this.rssType, this.icon, {this.title, this.baseUrl, this.type = RSS_TITLE.GOOGLE});

  @override
  String toString() {
    return 'ListFeedBookmarkModel{id:$id, title:$title, icon:$icon, url: $url, rssType: $rssType, baseUrl:$baseUrl}';
  }
}
