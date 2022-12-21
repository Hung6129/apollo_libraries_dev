import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  /// Menu popup
  static const String import = 'Nhập dữ liệu';
  static const String export = 'Xuất dữ liệu';
  static const String reset = 'Đặt lại hệ thống';

  /// Appbar title
  static const String connect = 'Kết nối';
  static const String disconnect = 'Ngắt kết nối';
  static const String scanTitle = 'Quét';
  static const String scanSubTitleUnProvisioned = 'Tìm kiếm các thiết bị proxy chưa được ghép nối vào mạng';
  static const String scanSubTitleProvisioned = 'Tìm kiếm các thiết bị proxy đã được ghép nối vào mạng';
  static const String nodeConfig = 'Cấu hình thiết bị';
  static String nodeConfigSub(String nodeName) => nodeName;

  /// Btn text
  static const String addNodes = 'Thêm thiết bị mới';
  static const String addGroups = 'Thêm nhóm mới';
  static const String addSence = 'Thêm ngữ cảnh';

  /// Text
  //
  static const String settingName = 'Tên';
  static const String settingProvisioners = 'Provisioners';
  static const String settingNetKeys = 'Network Keys';
  static const String settingAppKeys = 'Application Keys';
  static const String settingSences = 'Ngữ cảnh';
  static const String settingIVMode = 'Chế độ kiểm tra IV';
  static const String settingLastRest = 'Lần cuối đặt lại hệ thống';
  static const String settingAppVersion = 'Phiên bản phần mềm';
  //
  static const String underDevelopment = 'Tính năng đang được phát triển';
  //
  static const String noFoundSence = 'Không tìm thấy ngữ cảnh';
  static const String noFoundNode = 'Không tìm thấy thiết bị';
  static const String noFoundGroup = 'Không tìm thấy nhóm';
  //
  static const String noFoundNodeRecommending =
      '1. Đảm bảo nguồn được bật hoặc phải được kết nối với nguồn điện \n 2. Phải đảm bảo bạn đang đứng gần thiết bị có liên quan và không được quá xa';
  //
  static const String noSence = 'Chưa có ngữ cảnh';
  static const String noNode = 'Chưa có thiết bị nào được thêm vào mạng';
  static const String noGroup = 'Chưa có nhóm nào được thêm';
  //
  static const String noSenceRecommending = 'Tạo một ngữ cảnh để quản lý nhiều nhóm';
  static const String noNodeRecommending = 'Thêm một thiết bị mới bằng cách quét và ghép nối thiết bị';
  static const String noGroupRecommending =
      'Tạo nhóm để điều khiển các thiết bị của bạn \n Vào thiết bị và thêm vào nhóm';
  //
  static const String cancelText = 'Huỷ';
  static const String continueText = 'Tiếp tục';

  //
  static const String importData1 = 'Điều này sẽ xoá tất cả dữ liệu liên quan trên hệ thống và bạn không thể hồi phục';
  static const String importData2 = 'Note: Bạn có thể xuất dữ liệu cũ trước khi nhập dữ liệu mới';
  static const String importData3 = 'Bạn có chắc chắn muốn tiếp tục?';

  /// dialog text
  static const String dialogTitleData = 'Dữ liệu';
  static const String dialogImportDataFail =
      'Nhập dữ liệu mới vào hệ thống thất bại\n Hãy chọn file .json để nhập dữ liệu mới';
  static const String dialogImportDataSuccess = 'Nhập dữ liệu mới vào hệ thống thành công';
  static const String dialogResetDataSuccess = 'Đặt lại dữ liệu thành công';
  static const String dialogTitleUpdated = 'Cập nhật';
  static String dialogTitleUpdatedDelete(String name) => 'Xoá $name thành công';
  static const String dialogTitleAddNodeSuccess = 'Hoàn tất';
  static String dialogTitleSuccessMess(String device) => 'Đã thêm thiết bị vào mạng thành công $device';
  static const String dialogTitleFail = 'Đã có lỗi xảy ra';
  static String dialogTitleFailMess(String device, String error) => ' $device';
}
