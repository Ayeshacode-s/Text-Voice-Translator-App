import 'package:get/get.dart';

import 'credentialcontroller.dart';


class CredentialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CredentialController>(() => CredentialController());
  }
}
