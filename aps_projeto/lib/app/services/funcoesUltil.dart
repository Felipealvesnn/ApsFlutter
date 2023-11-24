import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart'; // importante pra data funcionar
import 'package:intl/intl.dart';

TimeOfDay _time = const TimeOfDay(hour: 00, minute: 00);

void showhora(BuildContext context, Rx<TextEditingController> model,
    {String? horainicial, String? horafinal}) async {
  final TimeOfDay? newTime = await showTimePicker(
    context: context,
    initialTime: _time,
  );
  if (horainicial != null && newTime != null) {
    final TimeOfDay minTime = parseTimeString(horainicial);

    if (newTime.hour < minTime.hour ||
        (newTime.hour == minTime.hour && newTime.minute < minTime.minute)) {
      // Horário selecionado é menor que 15:00, mostre uma mensagem de erro ou faça algo apropriado.
      // Por exemplo, você pode exibir um SnackBar com uma mensagem de erro.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O horario final tem q ser maior q o incial'),
        ),
      );
    } else {
      _time = newTime;
      model.value.text = _time.format(context);
    }
  }
  if ((horafinal != null && newTime != null)) {
    // Verifique se o horário selecionado é maior que 15:00 (3:00 PM)
    final TimeOfDay maxTime = parseTimeString(horafinal);

    if (newTime.hour > maxTime.hour ||
        (newTime.hour == maxTime.hour && newTime.minute > maxTime.minute)) {
      // Horário selecionado é menor que 15:00, mostre uma mensagem de erro ou faça algo apropriado.
      // Por exemplo, você pode exibir um SnackBar com uma mensagem de erro.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O horario INicial tem q ser menor q o final'),
        ),
      );
    }
  } else if (newTime != null) {
    _time = newTime;
    model.value.text = _time.format(context);
  }
}

Future<void> openCalendar(
    BuildContext context, Rx<TextEditingController> controller) async {
  await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  ).then((pickedDate) {
    if (pickedDate != null) {
      final selectedDate = pickedDate.toLocal().toString().split(' ')[0];
      controller.value.text = selectedDate;
    }
  });
}

TimeOfDay parseTimeString(String timeString) {
  // Use uma expressão regular para extrair a hora, os minutos e o período (AM/PM) da string
  final regex = RegExp(r'(\d+):(\d+) (AM|PM)');
  final match = regex.firstMatch(timeString);

  if (match != null && match.groupCount == 3) {
    try {
      var hour = int.parse(match.group(1)!);
      final minute = int.parse(match.group(2)!);
      final period = match.group(3);

      // Converta a hora para o formato de 24 horas se for PM
      if (period == 'PM' && hour < 12) {
        hour += 12;
      }

      // Crie e retorne o TimeOfDay
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      // Trate qualquer erro de análise de string aqui
      print('Erro ao analisar a string de tempo: $e');
    }
  }

  // Se a análise falhar ou o formato da string estiver incorreto, retorne um valor padrão (por exemplo, meia-noite)
  return const TimeOfDay(hour: 0, minute: 0);
}

DateTime parseTimeStringToDateTime(DateTime date, String timeString) {
  List<String> parts = timeString.split(" ");

  if (parts.length != 2) {
    throw ArgumentError("A string não está no formato correto.");
  }

  String timePart = parts[0];
  String amPmPart = parts[1];

  List<String> timeParts = timePart.split(":");

  if (timeParts.length != 2) {
    throw ArgumentError("A string não está no formato correto.");
  }

  int hours = int.parse(timeParts[0]);
  int minutes = int.parse(timeParts[1]);

  if (amPmPart == "PM" && hours != 12) {
    hours += 12;
  } else if (amPmPart == "AM" && hours == 12) {
    hours = 0;
  }

  return DateTime(date.year, date.month, date.day, hours, minutes);
}

IconButton buildDownwardIcon(BuildContext context,
    {Rx<TextEditingController>? model,
    String? horainicial,
    String? horafinal}) {
  return IconButton(
    icon: const Icon(Icons.keyboard_arrow_down),
    onPressed: model != null
        ? (horainicial != null
            ? () {
                showhora(context, model,
                    horainicial:
                        horainicial); // Chama a função de seleção de horário
              }
            : () {
                showhora(context, model,
                    horafinal:
                        horafinal); // Chama a função de seleção de horário
              })
        : null,
    color: Colors.black54,
  );
}

String formatDateTime(DateTime dateTime) {
  initializeDateFormatting();

  DateFormat dateFormat = DateFormat.yMd('pt_BR'); //.add_Hm();
  return dateFormat.format(dateTime).trim();
}