import 'package:cardi_care/views/onboarding_screen.dart';
import 'package:cardi_care/views/signas_screen.dart';
import 'package:cardi_care/views/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static String splash = '/';
  static String onboarding = '/onboarding';
  static String signAs = '/sign-as';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: signAs, page: () => const SignasScreen())
  ];
}
