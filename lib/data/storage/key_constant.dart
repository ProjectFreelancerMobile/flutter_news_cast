const String MIN_DATETIME = '1800-05-12';
const String MAX_DATETIME = '2023-05-25';
const String INIT_DATETIME = '1990-01-01';

enum STATUS_TYPE { FAIL, OK }

enum SEX_TYPE { MEN, WOMAN, OTHER }

enum SWITCH_TYPE { BLOCK_ADS, PLUGIN, NOTI }

enum RSS_TYPE { RSS, ATOM, JSON, UNKNOWN }

enum RSS_TITLE { THANHNIEN, YOUTUBE, VIMEO, DAILYMOTION, THEXIFFY, GOOGLE }

extension StatusTypeExt on STATUS_TYPE {
  String get name {
    switch (this) {
      case STATUS_TYPE.FAIL:
        return 'fail';
      case STATUS_TYPE.OK:
        return 'ok';
      default:
        return '';
    }
  }
}

extension RssNameExt on RSS_TYPE {
  int get indexValue {
    switch (this) {
      case RSS_TYPE.ATOM:
        return 0;
      case RSS_TYPE.JSON:
        return 1;
      case RSS_TYPE.RSS:
        return 2;
      default:
        return 2;
    }
  }
}

extension RssTypeExt on num {
  RSS_TYPE get type {
    switch (this) {
      case 0:
        return RSS_TYPE.ATOM;
      case 1:
        return RSS_TYPE.JSON;
      case 2:
        return RSS_TYPE.RSS;
      default:
        return RSS_TYPE.RSS;
    }
  }
}

extension RssTitleExt on RSS_TITLE {
  int get indexTitleValue {
    switch (this) {
      case RSS_TITLE.THANHNIEN:
        return 0;
      case RSS_TITLE.YOUTUBE:
        return 1;
      case RSS_TITLE.VIMEO:
        return 2;
      case RSS_TITLE.DAILYMOTION:
        return 3;
      case RSS_TITLE.THEXIFFY:
        return 4;
      default:
        return 5;
    }
  }
}

extension RssTitleIntExt on num {
  RSS_TITLE get typeTitle {
    switch (this) {
      case 0:
        return RSS_TITLE.THANHNIEN;
      case 1:
        return RSS_TITLE.YOUTUBE;
      case 2:
        return RSS_TITLE.VIMEO;
      case 3:
        return RSS_TITLE.DAILYMOTION;
      case 4:
        return RSS_TITLE.THEXIFFY;
      default:
        return RSS_TITLE.YOUTUBE;
    }
  }
}
