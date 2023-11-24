import 'dart:ffi';

import 'package:aps_projeto/app/models/objetoCadast.dart';
import 'package:aps_projeto/app/modules/cadastrar/controllers/cadastrar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CardForm extends StatelessWidget {
  final CadastrarController controller;
  confirmar(BuildContext context, ObjetoCadastrar formData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: const Text('Tem certeza de que deseja excluir este objeto?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Excluir o item e fechar o diálogo
                controller.deleteFormData(formData.id!);
                Navigator.of(context).pop();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  const CardForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Objetos Emprestados',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Obx(
            () {
              final List<ObjetoCadastrar> formDataList =
                  controller.listObjetos.value;

              if (formDataList.isEmpty) {
                return const Text('Nenhum objeto emprestado');
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (textoPesquisa) async {
                          // Implemente a lógica de pesquisa aqui
                          controller.searchTitle.value = textoPesquisa;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Pesquisar',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap:
                          true, // Adicione o shrinkWrap para evitar o erro
                      itemCount: formDataList.length,
                      itemBuilder: (context, index) {
                        ObjetoCadastrar formData = formDataList[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(formData.nome!),
                            subtitle:
                                Text('Devolução: ${formData.dataDevolucao}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                confirmar(context, formData);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
