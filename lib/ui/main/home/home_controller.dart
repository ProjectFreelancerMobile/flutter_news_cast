// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter_news_cast/data/api/models/feed_model.dart';
import 'package:get/get.dart';

import '../../base/base_controller.dart';

class HomeController extends BaseController {
  // final _mainController = Get.find<MainController>();
  // final _deviceRepository = Get.find<DeviceRepository>();
  // final _appController = Get.find<AppController>();
  // var _user = TUser().obs;
  //
  // TUser get user => _user.value;
  // final GlobalKey widgetKey = GlobalKey();
  //
  List<FeedModel> get listRecentFeed => _listFeed$.value;
  final _listRecentFeed$ = <FeedModel>[].obs;

  List<FeedModel> get listFeed => _listFeed$.value;
  final _listFeed$ = <FeedModel>[].obs;

  bool get isShowScreenError => false;

  @override
  void onClose() {
    print('HomeController:onClose');
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    // _user.value = _appController.user ?? TUser(name: '', gender: SEX_TYPE.MEN.name, phone: '');
    // autoRefreshList();
    initFakeData();
  }

  void initFakeData(){
    for (var i = 0; i < 20; i++) {
      _listRecentFeed$.add(FeedModel('https://photo.znews.vn/w660/Uploaded/oqivovbt/2019_01_05/jisoo_06.jpg', 'Recent $i'));
    }

    for (var i = 0; i < 20; i++) {
      _listFeed$.add(FeedModel('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWwlnjwnD3wQU6dq54xfcvN_h01gwBYpyOJQ&usqp=CAU', 'Feed $i'));
    }
  }
  //
  // void autoRefreshList({bool isFore = false}) async {
  //   print('HomeController:autoRefreshList:' + _mainController.pageIndex.value.toString());
  //   if (_mainController.pageIndex.value == 0 || isFore) {
  //     await getListDevice();
  //     periodicTimer?.cancel();
  //     periodicTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
  //       periodicTimer = timer;
  //       await getListDevice(isShowLoading: false);
  //     });
  //   }
  // }
  //
  // MainController get getMainController => _mainController;
  //
  // Future<void> getListDevice({bool? isShowLoading = true}) async {
  //   try {
  //     if (AppPopup.pairDevice) return;
  //     if (isShowLoading == true) {
  //       showLoading();
  //     }
  //     await _deviceRepository.getListDevice(_mainController.farmPick).then((value) {
  //       if (value != null) {
  //         _listDevice$.value = value;
  //         Logger(
  //                 printer: PrettyPrinter(
  //                     methodCount: 2,
  //                     // Number of method calls to be displayed
  //                     errorMethodCount: 8,
  //                     // Number of method calls if stacktrace is provided
  //                     lineLength: 120,
  //                     // Width of the output
  //                     colors: true,
  //                     // Colorful log messages
  //                     printEmojis: true,
  //                     // Print an emoji for each log message
  //                     printTime: true // Should each log print contain a timestamp
  //                     ))
  //             .i("getListDevice::");
  //       }
  //     });
  //     if (isShowLoading == true) {
  //       hideLoading();
  //     }
  //   } catch (e) {
  //     if (isShowLoading == true) {
  //       hideLoading();
  //     }
  //     showMessage(getErrors(e), isForeShow: isShowLoading == true);
  //   }
  // }
  //
  // Future<void> pushDevice(DeviceItem? deviceItem, String? sn, {Function(bool)? isState}) async {
  //   try {
  //     if (sn == null || deviceItem == null) return isState != null ? isState(false) : null;
  //     showLoading();
  //     await _deviceRepository.pushDevice(sn: sn).then((value) {
  //       if (value != null) {
  //         if (value.state == true) {
  //           isState != null ? isState(true) : null;
  //           final deviceUpdate = deviceItem.copyWith(data: CONTROL_TYPE.ON.name);
  //           listDevice[listDevice.indexWhere((element) => element.serialNo == sn)] = deviceUpdate;
  //         } else if (value.state == false) {
  //           isState != null ? isState(false) : null;
  //           final deviceUpdate = deviceItem.copyWith(data: CONTROL_TYPE.OFF.name);
  //           listDevice[listDevice.indexWhere((element) => element.serialNo == sn)] = deviceUpdate;
  //         }
  //         _listDevice$.value = listDevice;
  //       } else {
  //         isState != null ? isState(false) : null;
  //         showMessage(textLocalization('data.error'));
  //       }
  //     });
  //     hideLoading();
  //   } catch (e) {
  //     isState != null ? isState(false) : null;
  //     hideLoading();
  //     showMessage(getErrors(e));
  //   }
  // }
  //
  // void updateName(String nameUpdate) {
  //   _user.update((_user) {
  //     user.updateUser(name: nameUpdate);
  //   });
  //   print('updateName:::' + user.name.toString());
  // }
  //
  // onGotoAddDevice() {
  //   periodicTimer?.cancel();
  //   Get.toNamed(AppRoutes.ADD_DEVICE);
  // }
  //
  // onGotoManagerDevice(DeviceItem deviceItem) {
  //   periodicTimer?.cancel();
  //   removePopUp();
  //   Get.toNamed(AppRoutes.MANAGER_DEVICE, arguments: deviceItem);
  // }
  //
  // removePopUp() {
  //   _mainController.appPopup?.removePopup();
  // }
  //
  // getPopup() => _mainController.appPopup;
  //
  // @override
  // void dispose() {
  //   periodicTimer?.cancel();
  //   super.dispose();
  // }
}
