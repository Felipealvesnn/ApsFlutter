import 'package:get/get.dart';

import '../controllers/cadastrar_controller.dart';

class CadastrarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CadastrarController>(
      () => CadastrarController(),
    );
  }
}
