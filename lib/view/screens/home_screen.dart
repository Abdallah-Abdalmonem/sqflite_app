import 'package:flutter/material.dart';

import '../../sqflite.dart';
import '../widgets/custom_text_filed.dart';
import '../widgets/noteItem.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final dataKey = new GlobalKey();

  SqlDb sqlDb = SqlDb();

  List nameList = [];
  List noteList = [];
  List idList = [];
  var nameController = TextEditingController();
  var noteController = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      getTasks();
    });
  }

  getTasks() async {
    nameList = [];
    noteList = [];
    idList = [];
    List response = await sqlDb.readData();

    for (int i = 1; i < response.length; i++) {
      nameList.add(response[i]['Name']);
      noteList.add(response[i]['Notes']);
      idList.add(response[i]['id']);
    }
    print(response);
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  customTextFiled(
                      controller: nameController,
                      label: 'your Name',
                      padding: 20),
                  customTextFiled(
                      controller: noteController,
                      label: 'your Note',
                      padding: 20),
                  ElevatedButton(
                      onPressed: () async {
                        int response = await sqlDb.insertData(
                            name: nameController.text,
                            note: noteController.text);
                        nameController.text = '';
                        noteController.text = '';
                        await getTasks();
                      },
                      child: const Text(
                        'Add Note',
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              reverse: true,
              itemBuilder: (context, index) {
                return noteItem(
                    name: nameList[index],
                    note: noteList[index],
                    id: idList[index],
                    sqlDb: sqlDb,
                    getTasks: () => getTasks());
              },
              itemCount: idList.length,
            ),
          )
        ],
      ),
      // Todo
      // bottomNavigationBar: new ElevatedButton(
      //   onPressed: () => Scrollable.ensureVisible(dataKey.currentContext!),
      //   child: new Text("Scroll to data"),
      // ),
    );
  }
}
