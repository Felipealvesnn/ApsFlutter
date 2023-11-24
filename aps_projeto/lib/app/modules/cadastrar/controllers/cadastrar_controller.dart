import 'package:aps_projeto/app/data/db.util.dart';
import 'package:aps_projeto/app/models/objetoCadast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class CadastrarController extends GetxController {
  //TODO: Implement CadastrarController
  final formKey = GlobalKey<FormState>();
  RxList<ObjetoCadastrar> listObjetos = <ObjetoCadastrar>[].obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  late TextEditingController nomeController;
  late TextEditingController classificacaoController;
  late TextEditingController nomePessoaController;
  late Rx<TextEditingController> dataDevolucaoController;
 // final dataDevolucaoController = MaskedTextController(mask: '00/00/0000');
  late TextEditingController observacoesController;
   RxString searchTitle = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    nomeController = TextEditingController();
    classificacaoController = TextEditingController();
    nomePessoaController = TextEditingController();
    dataDevolucaoController = TextEditingController().obs;
    observacoesController = TextEditingController();

    await getAllFormData();

     debounce(
      searchTitle,
      (callback) {
        print("callback  as Strin");
        pesquisarObjeto(searchTitle.value);
       // update();
      },
      time: const Duration(milliseconds: 600),
    );

  }

  Future<void> deleteFormData(int id) async {
    await DbUtil.deleteFormData(id);

    await getAllFormData();
  }

  Future<void> getAllFormData() async {
    final ojetos = await DbUtil.getAllFormData();
    listObjetos.value = ojetos;
  }
  Future<void> pesquisarObjeto(String nome) async {
    final ojetos = await DbUtil.getAllFormData(searchText: nome);
    listObjetos.value = ojetos;
  }

  Future<void> enviarFormulario() async {
    if (formKey.currentState!.validate()) {
      final formData = ObjetoCadastrar(
        nome: nomeController.text,
        classificacao: classificacaoController.text,
        nomePessoa: nomePessoaController.text,
        dataDevolucao: dataDevolucaoController.value.text,
        observacoes: observacoesController.text,
      );
      await DbUtil.insertFormData(formData);
      await getAllFormData();

      nomeController.clear();
      classificacaoController.clear();
      nomePessoaController.clear();
      dataDevolucaoController.value.clear();
      observacoesController.clear();
      Get.snackbar(
        'Sucesso',
        'Objeto cadastrado com sucesso',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }

    // Aqui você pode fazer o que quiser com os dados do formulário
    // Exibindo os dados (apenas para fins de demonstração)
  }
}
