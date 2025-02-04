import 'package:get/get.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/home/presentation/home_page.dart';
import 'package:vinemas_v1/features/login/presentation/login_page.dart';
import 'package:vinemas_v1/features/pay/presentation/pay_page.dart';
import 'package:vinemas_v1/features/profile/presentation/profile_page.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/about_sessions_page.dart';
import 'package:vinemas_v1/features/seat_reservation/presentation/seat_reservation_page.dart';
import 'package:vinemas_v1/features/splash/presentation/splash_page.dart';
import 'package:vinemas_v1/features/ticket/presentation/ticket_page.dart';

class AppGenerateRouter {
  static final routes = [
    GetPage(name: ConfigRoute.splash_page, page: () => SplashPage()),
    GetPage(name: ConfigRoute.login_page, page: () => LoginPage()),
    GetPage(name: ConfigRoute.home_page, page: () => HomePage()),
    GetPage(
        name: ConfigRoute.about_sessions_page, page: () => AboutSessionsPage()),
    GetPage(
        name: ConfigRoute.seat_reservation_page,
        page: () => SeatReservationPage()),
    GetPage(name: ConfigRoute.pay_page, page: () => PayPage()),
    GetPage(name: ConfigRoute.ticket_page, page: () => TicketPage()),
    GetPage(name: ConfigRoute.profile_page, page: () => ProfilePage()),
  ];
}
