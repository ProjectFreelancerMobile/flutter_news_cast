const String MIN_DATETIME = '1800-05-12';
const String MAX_DATETIME = '2023-05-25';
const String INIT_DATETIME = '1990-01-01';
const String fkTest = ""; //"YNAt3Y51";
const String ukTest = ""; //"/4mkVhaEkQVbtSpy+p1bMUpOpntpT66ZhYKwf692VDY=";

enum ADD_DEVICE_TYPE { WIFI, SEARCH, REGISTER, CREATE, DONE }

enum DEVICE_TYPE { WATER, AIR, CONTROL }

enum SIZE_TYPE { NONE, M2, HA }

enum DATE_TYPE { NOW, LAST, WEEK, RANGE }

enum SEX_TYPE { MEN, WOMAN, OTHER }

enum STATUS_TYPE { FAIL, OK }

enum CONTROL_TYPE { ON, OFF }

enum SOCIAL_TYPE { GOOGLE, FACEBOOK, ZALO }

extension DeviceTypeExt on DEVICE_TYPE {
  num get name {
    switch (this) {
      case DEVICE_TYPE.WATER:
        return 1;
      case DEVICE_TYPE.AIR:
        return 2;
      case DEVICE_TYPE.CONTROL:
        return 3;
      default:
        return 0;
    }
  }
}

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

extension SocialTypeExt on SOCIAL_TYPE {
  String get name {
    switch (this) {
      case SOCIAL_TYPE.FACEBOOK:
        return 'facebook';
      case SOCIAL_TYPE.GOOGLE:
        return 'google';
      case SOCIAL_TYPE.ZALO:
        return 'zalo';
      default:
        return '';
    }
  }
}

extension SexTypeExt on SEX_TYPE {
  num get name {
    switch (this) {
      case SEX_TYPE.WOMAN:
        return 0;
      case SEX_TYPE.MEN:
        return 1;
      default:
        return 1;
    }
  }
}

extension SizeTypeExt on SIZE_TYPE {
  String get name {
    switch (this) {
      case SIZE_TYPE.M2:
        return "m2";
      case SIZE_TYPE.HA:
        return "ha";
      default:
        return "m2";
    }
  }
}

extension ControlTypeExt on CONTROL_TYPE {
  String get name {
    switch (this) {
      case CONTROL_TYPE.ON:
        return "on";
      case CONTROL_TYPE.OFF:
        return "off";
      default:
        return "off";
    }
  }
}
