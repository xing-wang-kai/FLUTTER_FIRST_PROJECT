import 'package:flutter/material.dart';
import 'package:my_frist_flutter_project/data/task_dao.dart';
import 'package:path/path.dart';

Future<void> showMyDialog(BuildContext context, String taskName) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('DELETAR ESSE CARD?'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text('Atenção!', style: TextStyle(color: Colors.red)),
              ),
              Center(
                child: Text(
                  'Essa ação é permanente você realmente deseja continuar?',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('NÃO'),
            onPressed: () {
              TaskDao().delete(taskName);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('SIM'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
