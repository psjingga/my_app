import 'package:go_router/go_router.dart';
import 'package:my_app_new/error.dart';
import 'package:my_app_new/home.dart';
import 'package:my_app_new/login.dart';
import 'package:my_app_new/profile.dart';
import 'package:my_app_new/splashscreen.dart';

abstract class PageName {
  static const splashRoute = '/';
  static const loginRoute = '/login';
  static const homeRoute = '/homepage';
  static const profileRoute = '/profile';
  static const galeriRoute = '/galeri';
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
      path: '${PageName.profileRoute}/:nama/:age/:email',
      name: 'profile',
      builder: (context, state) => profilePage(
        nama: state.pathParameters['nama'],
        age: state.pathParameters['age'],
        email: state.pathParameters['email'],
      ),
    ),
    GoRoute(
      path: PageName.galeriRoute,
      name: 'galeri',
      builder: (context, state) => homePage(),
    )
  ],
);
