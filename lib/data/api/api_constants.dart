const DATE_TIME_FORMAT = "yyyy-MM-ddTHH:mm:ssZ";
const DATE_TIME_FORMAT2 = "dd/MM/yyyy HH:mm";
const DATE_TIME_FORMAT_NOTIFICATION = "HH:mm dd/MM/yyyy";
const DATE_TIME_FORMAT_PAYMENT = "dd/MM/yyyy HH:mm:ss";
const DATE_FORMAT = "dd/MM/yyyy";
const DATE_FORMAT2 = "dd-MM-yyyy";
const DATE_FORMAT3 = "yyyy-MM-dd";
const DATE_OF_WEEK_FORMAT = "EEE, dd/MM";
const TIME_FORMAT = "HH:mm";

const DATE_FORMAT_NOTIFICATION_DAY = "EEE, dd";
const DATE_FORMAT_NOTIFICATION_YEAR = "MM, yyyy";
final minDate = DateTime(1900, 1, 1, 0, 0, 0);
final maxDate = DateTime(3000, 1, 1, 0, 0, 0);
const MIN_YEAR_OLD_USED_APP = 18;
const PAGE_SIZE = 30;
const BASE_URL_DEV = "http://51.79.181.193:3334";
//const BASE_URL_DEV = "http://10.0.2.2:8080";
const UPLOAD_PHOTO_URL_DEV = "https://api.urvega.com/";
const DOWNLOAD_PHOTO_URL_DEV = "https://api.urvega.com/";
const BASE_URL_PROD = "https://api.urvega.com/"; // production
const UPLOAD_PHOTO_URL_PROD = "https://api.urvega.com/"; //production
const DOWNLOAD_PHOTO_URL_PROD = "https://api.urvega.com/"; // production

String PHOTO_URL_CDN = BASE_URL_DEV;
//Login
const LOGIN_BY_EMAIL = "/auth/login";
const GET_BALANCER = "/auth/get_balance";
//Payment
const PAYMENT_GET_TKCT = "/auth/get_tkct";
const PAYMENT_ADD_TKCT = "/auth/add_tkct_new";
const PAYMENT_EDIT_TKCT = "/auth/update_tkct";
const PAYMENT_DELETE_TKCT = "/auth/delete_tkct";
const PAYMENT_ADD_BILL = "/auth/add_balance";
const PAYMENT_CK = "/auth/chuyen_tien";
const PAYMENT_INFO = "/lookup";
const PAYMENT_STK = "/auth/get_tkct_bank";
