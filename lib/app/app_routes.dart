part of 'app_pages.dart';

abstract class AppRoutes {
  static const INITIAL = '/';
  static const MAIN = '/main';
  static const SPLASH = '/splash';
  static const REGISTER = '/register';
  static const OTP_REGISTER = '/otp';
  static const LIST_NOTIFICATION = '/list_notification';
  static const SECURITY = '/security';
  static const SECURITY_EMAIL = '/security_email';
  static const SECURITY_LINK = '/security_link';
  static const SETTING_NOTIFICATION = '/setting_notification';
  static const MANAGER = '/manager';
  static const MANAGER_SEARCH_LOCATION = '/manager_search';
  static const MANAGER_SIZE = '/manager_size';
  static const ADD_DEVICE = '/add_device';
  static const CHART_DETAIL = '/chart_detail';
  static const MANAGER_DEVICE = '/manager_device';
  static const MANAGER_LIST_DEVICE = '/manager_list_device';
  static const SETTING_DEVICE = '/setting_device';
  static const DEVICE_CHART_DETAIL = MANAGER_DEVICE + CHART_DETAIL;

  static const UPDATE_PROFILE = '/update';
  static const INTRODUCE = '/introduce';
  static const LIST_PROMOTION = '/list_promotion';
  static const SEARCH = '/search';
  static const DISCOVER_MORE = '/discover_more';
  static const PLACES = '/places';
  static const OPTION_BOOKING = '/option_booking';
  static const INFO_PAYMENT = '/info_payment';
  static const PHONE_COUNTRY = '/phone_country';
  static const MEDICAL = '/medical';
  static const DISCOVER_SEARCH = '/discover_search';
  static const DISCOVER_DETAIL = '/discover_detail';
  static const PLACE_DETAIL = '/place_detail';

  static const MY_CART = '/my_cart';
  static const POST_COMMENT = '/post_comment';
  static const TOPIC_DISCOVER = '/topic_discover';

  // date
  static const CHOOSE_DATE_RANGE = '/choose_date_range';

  //Hotel
  static const HOTEL = '/hotel';
  static const SEARCH_PLACE = '/search_place';
  static const HOTEL_DETAIL = '/hotel_detail';
  static const HOTEL_UTILITIES = '/hotel_utilities';
  static const ROOM_UTILITIES = '/room_utilities';
  static const FIND_ROOM_INFO = '/find_room_info';
  static const FIND_ROOM_RESULT = '/find_room_result';
  static const FILTER_HOTEL_INFO = '/filter_hotel_info';
  static const BOOKING = '/booking';
  static const HOTEL_VIEW_MORE = '/hotel_view_more';
}
