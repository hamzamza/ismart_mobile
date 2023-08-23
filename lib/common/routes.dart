import 'package:flutter/cupertino.dart';
import '/common/ui/screens/home_screen/home_screen.dart';

import '../features/stations_feature/screens/charging_screen.dart';
import '../features/stations_feature/screens/search_screen.dart';

const String homeScreenPath = '/';
const String loginScreenRoute = '/login_screen_route';
const String chargingScreenRoute = '/charging_screen_route';
const String searchScreenRoute = '/search_screen_route';

Map<String, WidgetBuilder> routes = {
  homeScreenPath: (context) => const HomeScreen(),
  // loginScreenRoute: (context) => const LoginScreen(),
  chargingScreenRoute: (context) => const ChargingScreen(),
  searchScreenRoute: (context) => const SearchScreen(),
};
