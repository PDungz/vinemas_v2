import 'package:get/get.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/about/presentation/about_page.dart';
import 'package:vinemas_v1/features/home/presentation/home_page.dart';
import 'package:vinemas_v1/features/login/presentation/login_page.dart';
import 'package:vinemas_v1/features/pay/presentation/pay_page.dart';
import 'package:vinemas_v1/features/profile/presentation/profile_page.dart';
import 'package:vinemas_v1/features/sessions/presentation/sessions_page.dart';
import 'package:vinemas_v1/features/splash/presentation/splash_page.dart';
import 'package:vinemas_v1/features/ticket/presentation/ticket_page.dart';

class AppGenerateRouter {
  static final routes = [
    GetPage(name: ConfigRoute.splash, page: () => SplashPage()),
    GetPage(name: ConfigRoute.login, page: () => LoginPage()),
    GetPage(name: ConfigRoute.home, page: () => HomePage()),
    GetPage(name: ConfigRoute.about, page: () => AboutPage()),
    GetPage(name: ConfigRoute.sessions, page: () => SessionsPage()),
    GetPage(name: ConfigRoute.pay, page: () => PayPage()),
    GetPage(name: ConfigRoute.ticket, page: () => TicketPage()),
    GetPage(name: ConfigRoute.profile, page: () => ProfilePage()),
  ];
}
