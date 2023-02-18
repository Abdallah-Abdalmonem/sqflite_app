import 'package:flutter/material.dart';

import '../../sqflite.dart';

Widget noteItem(
    {required String name,
    required String note,
    required SqlDb sqlDb,
    required int id,
    required getTasks}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[900],
      ),
      height: 100,
      child: ListTile(
        textColor: Colors.black,
        trailing: SizedBox(
            height: 60,
            width: 60,
            child: Row(
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () async {
                      await sqlDb.updateData(id: id, name: 'abdallah');
                      getTasks();

                      print('iddddddddddddddddddddddd= $id');
                      return;
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.green,
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () async {
                      sqlDb.deleteData(id: id);
                      getTasks();
                      print('iddddddddddddddddddddddd= $id');
                      return;
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            )),
        title:
            Text('$name', style: TextStyle(fontSize: 26, color: Colors.white)),
        subtitle: Text('${note}',
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    ),
  );
}
