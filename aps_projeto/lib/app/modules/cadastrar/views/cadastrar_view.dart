import 'package:aps_projeto/app/modules/cadastrar/views/Widget/card.dart';
import 'package:aps_projeto/app/modules/cadastrar/views/Widget/form.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cadastrar_controller.dart';

class CadastrarView extends GetView<CadastrarController> {
  const CadastrarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CadastrarView'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        // Adiciona um SingleChildScrollView ao redor da Column
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyForm(
              controller: controller,
            ),
            CardForm(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
