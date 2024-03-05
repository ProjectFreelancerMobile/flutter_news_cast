
import 'package:flutter_news_cast/data/api/models/rss/feed_model.dart';

import 'post_model.dart';

class ListFeedModel {
  FeedModel? feedModel;
  List<PostModel?>? listPost;

  ListFeedModel({
    this.feedModel,
    this.listPost,
  });

  @override
  String toString() {
    return 'ListFeedModel{feedModel: $feedModel, listPost: $listPost}';
  }

}
