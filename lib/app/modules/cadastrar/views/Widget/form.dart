import 'package:aps_projeto/app/services/funcoesUltil.dart';
import 'package:flutter/material.dart';
import 'package:aps_projeto/app/modules/cadastrar/controllers/cadastrar_controller.dart';
import 'package:get/get.dart';

class MyForm extends StatelessWidget {
  final CadastrarController controller;

  const MyForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controller.classificacaoController,
              decoration: const InputDecoration(labelText: 'Classificação'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a classificação';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controller.nomePessoaController,
              decoration: const InputDecoration(labelText: 'Nome da Pessoa'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome da pessoa';
                }
                return null;
              },
            ),
            Obx(
              () =>
                  // Campo para a data de devolução
                  TextFormField(
                onTap: () {
                  openCalendar(context, controller.dataDevolucaoController);
                },
                controller: controller.dataDevolucaoController.value,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Data de Devolução',
                  suffixIcon: IconButton(
                    onPressed: () {
                      openCalendar(context, controller.dataDevolucaoController);
                      Get.focusScope!.unfocus();
                      //FocusScope.of(context).unfocus();
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data';
                  }
                  return null;
                },
              ),
            ),
            TextFormField(
              controller: controller.observacoesController,
              decoration: const InputDecoration(labelText: 'Observações'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Validação e envio do formulário
                if (controller.formKey.currentState!.validate()) {
                  await controller.enviarFormulario();
                }
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
