import 'package:aps_projeto/app/modules/cadastrar/bindings/cadastrar_binding.dart';
import 'package:aps_projeto/app/modules/cadastrar/views/cadastrar_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const CadastrarView(),
      bindings: [
        CadastrarBinding(),
      ],
    ),
  ];
}
