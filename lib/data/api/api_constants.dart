const DATE_TIME_FORMAT = "yyyy-MM-ddTHH:mm:ssZ";
const DATE_TIME_FORMAT2 = "dd/MM/yyyy HH:mm";
const DATE_FORMAT = "dd/MM/yyyy";
const DATE_FORMAT2 = "dd-MM-yyyy";
const DATE_FORMAT3 = "yyyy-MM-dd";
const DATE_OF_WEEK_FORMAT = "EEE, dd/MM";
const TIME_FORMAT = "HH:mm";
final minDate = DateTime(1900, 1, 1, 0, 0, 0);
final maxDate = DateTime(3000, 1, 1, 0, 0, 0);
const MIN_YEAR_OLD_USED_APP = 18;
const PAGE_SIZE = 30;
const BASE_URL_DEV = "https://api.urvega.com/";
const UPLOAD_PHOTO_URL_DEV = "https://api.urvega.com/";
const DOWNLOAD_PHOTO_URL_DEV = "https://api.urvega.com/";
const URL_PAIR = "http://192.168.1.86:8686/";
const BASE_URL_PROD = "https://api.urvega.com/"; // production
const UPLOAD_PHOTO_URL_PROD = "https://api.urvega.com/"; //production
const DOWNLOAD_PHOTO_URL_PROD = "https://api.urvega.com/"; // production
var isConnection = true;

String PHOTO_URL_CDN = BASE_URL_DEV;
//Login
const LOGIN_BY_EMAIL = "auth/login";
const LOGIN_BY_SOCIAL = "auth/slogin";
//Register
const REGISTER = "auth/register";
//OTP
const VERIFY_OTP = "code/check";
const REQUEST_OTP = "code/generate";
//Profile
const GET_PROFILE = "profile/fetch";
const UPDATE_PROFILE = "profile/update";

// firebase
const PUSH_DEVICE_TOKEN = "/v1/app/device/%s";

//Farm
const GET_ALL_FARM = "farm/all";
const GET_FARM = "farm/one";
const CREATE_FARM = "farm/add";
const UPDATE_FARM = "farm/update";
const REGION_PROVINCE = "region/province";
const REGION_DISTRICT = "region/district";
const REGION_WARD = "region/ward";

//Device
const GET_ALL_DEVICE = "device/all";
const GET_DEVICE = "device/one";
const UPDATE_DEVICE = "device/update";
const PAIR_DEVICE = "pair";
const VERIFY_DEVICE = "device/verify";
const PUSH_DEVICE = "device/push";
const DELETE_DEVICE = "device/remove";
const CHART_DEVICE = "device/chart";
