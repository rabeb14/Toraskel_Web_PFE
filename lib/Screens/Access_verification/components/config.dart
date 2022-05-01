import '../../../handler.dart';

class Config {
  static const String appName = "toraskel";
  static String apiURL= Handler().baseurl.substring(7);
  static const String otpLoginAPI = "/user/otpLogin";
  static const String verifyOTPAPI = "/user/verifyOTP";
}
