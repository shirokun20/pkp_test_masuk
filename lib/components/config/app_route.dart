// ignore_for_file: unused_import

import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../features/crud/binding/post_data_binding.dart';
import '../../features/crud/binding/post_form_binding.dart';
import '../../features/crud/presentation/post_data/post_data_screen.dart';
import '../../features/crud/presentation/post_form/post_form_screen.dart';
import '../../features/dummy/binding/dummy_binding.dart';
import '../../features/dummy/presentation/dummy_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../main.dart';


class AppRoute {
  static const String defaultRoute = '/';
  static const String notFound = '/notFound';
  static const String dummy = '/dummy';
  static const String postData = '/postData';
  static const String postForm = '/postForm';
  static List<GetPage> pages = [
    GetPage(name: defaultRoute, page: () => const SplashScreen()),
    GetPage(name: dummy, page: () => const DummyScreen(), binding: DummyBinding()),
    GetPage(name: postData, page: () => const PostDataScreen(), binding: PostDataBinding()),
    GetPage(name: postForm, page: () => const PostFormScreen(), binding: PostFormBinding()),
  ];
}