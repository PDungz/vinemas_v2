import 'package:get/get.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/home/presentation/home_page.dart';
import 'package:vinemas_v1/features/login/presentation/login_page.dart';
import 'package:vinemas_v1/features/login/presentation/page/forgot_password_page.dart';
import 'package:vinemas_v1/features/login/presentation/page/sign_up_page.dart';
import 'package:vinemas_v1/features/login/presentation/page/enter_verification_code_page.dart';
import 'package:vinemas_v1/features/pay/presentation/pay_page.dart';
import 'package:vinemas_v1/features/profile/presentation/profile_page.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/about_sessions_page.dart';
import 'package:vinemas_v1/features/seat_reservation/presentation/seat_reservation_page.dart';
import 'package:vinemas_v1/features/splash/presentation/splash_page.dart';
import 'package:vinemas_v1/features/ticket/presentation/ticket_page.dart';

class AppGenerateRouter {
  static final routes = [
    GetPage(name: ConfigRoute.splashPage, page: () => SplashPage()),
    GetPage(name: ConfigRoute.loginPage, page: () => LoginPage()),
    GetPage(name: ConfigRoute.signUpPage, page: () => SignUpPage()),
    GetPage(
        name: ConfigRoute.forgotPasswordPage, page: () => ForgotPasswordPage()),
    GetPage(
        name: ConfigRoute.verifyYourAccountPage,
        page: () => EnterVerificationCodePage()),
    GetPage(name: ConfigRoute.homePage, page: () => HomePage()),
    GetPage(
        name: ConfigRoute.aboutSessionsPage, page: () => AboutSessionsPage()),
    GetPage(
        name: ConfigRoute.seatReservationPage,
        page: () => SeatReservationPage()),
    GetPage(name: ConfigRoute.payPage, page: () => PayPage()),
    GetPage(name: ConfigRoute.ticketPage, page: () => TicketPage()),
    GetPage(name: ConfigRoute.profilePage, page: () => ProfilePage()),
  ];
}
