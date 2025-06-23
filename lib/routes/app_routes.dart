import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/onboarding_flow/onboarding_flow.dart';
import '../presentation/authentication_login_register/authentication_login_register.dart';
import '../presentation/coach_search_discovery/coach_search_discovery.dart';
import '../presentation/home_dashboard/home_dashboard.dart';
import '../presentation/coach_profile_detail/coach_profile_detail.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String onboardingFlow = '/onboarding-flow';
  static const String authenticationLoginRegister =
      '/authentication-login-register';
  static const String homeDashboard = '/home-dashboard';
  static const String coachSearchDiscovery = '/coach-search-discovery';
  static const String coachProfileDetail = '/coach-profile-detail';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    onboardingFlow: (context) => const OnboardingFlow(),
    authenticationLoginRegister: (context) =>
        const AuthenticationLoginRegister(),
    homeDashboard: (context) => const HomeDashboard(),
    coachSearchDiscovery: (context) => const CoachSearchDiscovery(),
    coachProfileDetail: (context) => const CoachProfileDetail(),
  };
}
