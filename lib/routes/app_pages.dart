import 'package:get/get.dart';

import '../appview/bottombar.dart';
import '../appview/login.dart';
import '../appview/signup.dart';
import '../controller/binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    ///----Auth---///
    GetPage(
      name: _Paths.login,
      page: () => Login(),
      binding: CredentialBinding(),
    ),
    GetPage(
      name: _Paths.signUp,
      page: () => Signup(),
      binding: CredentialBinding(),
    ),
    GetPage(
      name: _Paths.bottomBarHome,
      page: () => BottomBarWidget(),
      binding: CredentialBinding(),
    ),
  ];
}


// }
