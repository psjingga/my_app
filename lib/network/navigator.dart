import 'package:go_router/go_router.dart';
import 'package:my_app_new/error.dart';
import 'package:my_app_new/home.dart';
import 'package:my_app_new/home_new.dart';
import 'package:my_app_new/login.dart';
import 'package:my_app_new/pages/future_provider.dart';
import 'package:my_app_new/pages/stream_provider.dart';
import 'package:my_app_new/profile.dart';
import 'package:my_app_new/splashscreen.dart';

abstract class PageName {
  static const splashRoute = '/';
  static const loginRoute = '/login';
  static const homeRoute = '/homepage';
  static const profileRoute = '/profile';
  static const homeNewRoute = '/homeNew';
  static const futureRoute = '/future';
  static const streamRoute = '/stream';
}

final router = GoRouter(
  errorBuilder: (context, state) => errorPage(),
  initialLocation: PageName.splashRoute,
  routes: [
    GoRoute(
      path: '/',
      name: 'splashscreen',
      builder: (context, state) => Splashscreen(),
    ),
    GoRoute(
      path: PageName.loginRoute,
      name: 'login',
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: '${PageName.homeRoute}/:email',
      name: 'homepage',
      builder: (context, state) => homePage(
        email: state.pathParameters['email'],
      ),
    ),
    GoRoute(
      path: '${PageName.profileRoute}/:name/:age/:email',
      name: 'profile',
      builder: (context, state) => profilePage(
        nama: state.pathParameters['name'],
        age: state.pathParameters['age'],
        email: state.pathParameters['email'],
      ),
    ),
    GoRoute(
      path: PageName.homeNewRoute,
      name: 'homeNew',
      builder: (context, state) => Home(),
    ),
    GoRoute(
      path: PageName.futureRoute,
      name: 'future',
      builder: (context, state) => FutureProviderView(),
    ),
    GoRoute(
      path: PageName.streamRoute,
      name: 'stream',
      builder: (context, state) => StreamProviderView(),
    )
  ],
);
