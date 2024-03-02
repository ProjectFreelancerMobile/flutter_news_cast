import 'package:get/get.dart';

import '../../data/api/models/notification_item.dart';
import '../../ui/base/base_list_controller.dart';

class ListNotificationController extends BaseListController<NotificationItem> {
  final menu = ["Tất cả hoạt động", "Thông báo tài khoản", "Nhắc nhở", "Thông báo hệ thống"];
  var selectedMenu = "Tất cả hoạt động".obs;

  @override
  Future<List<NotificationItem>?> getData() async {
    return ListTest;
  }

  final ListTest = [
    NotificationItem(
        isRead: false.obs, type: "system", title: "Tài khoản của bạn đã hoàn tất chưa?", content: "Cập nhật ngay số điện thoại, địa chỉ email để hưởng ngay những ưu đãi nhé"),
    NotificationItem(isRead: false.obs, title: "DUY NHẤT HÔM NAY", content: "Mua voucher được giảm giá ngay 150K mua nhanh kẻo hết mấy bạn ơi"),
    NotificationItem(
        isRead: true.obs,
        type: "account",
        image: "https://danatravel.vn/data/tour/900/ba-na-1560224326.jpg",
        content: "Hạ Ngân Nguyễn chia sẻ bài viết Kinh nghiệm du lịch Phú Quốc "),
    NotificationItem(type: "payment", isRead: true.obs, title: "Thanh toán thành công", content: "Bạn đã thanh toán thành công đơn hàng H591061. Nhấn vào xem lại chi tiết."),
    NotificationItem(isRead: true.obs, title: "Nâng cấp hệ thống", content: "Các kênh liên hệ hỗ trợ khách hàng của chúng tôi sẽ bị gián đoạn 22h tối hôm nay(9/5) đến…")
  ];
}
