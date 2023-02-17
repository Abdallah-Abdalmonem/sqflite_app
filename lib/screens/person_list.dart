import 'package:flutter/material.dart';
import 'package:sqlite_flutter/models/person.dart';
import 'package:sqlite_flutter/screens/person_details.dart';

class PersonList extends StatefulWidget {
  @override
  State<PersonList> createState() => _MyWidgetState();
}

List<Person>? personList;

class _MyWidgetState extends State<PersonList> {
  int count = 0;

  void updateListView() {
    personList = [];
    personList?.add(Person(id: 1, name: 'abdallah', age: 22));
    personList?.add(Person(id: 2, name: 'mohamed', age: 21));
    personList?.add(Person(id: 3, name: 'ahmed', age: 23));
  }

  @override
  Widget build(BuildContext context) {
    if (personList == null) {
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Person App'),
        backgroundColor: Colors.grey,
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          NavigatorToDetail(Person.getNewEmpty());
        },
      ),
    );
  }

  void NavigatorToDetail(Person person) async {
    bool result = await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return PersonDetails(person: person);
      },
    ));
    if (result == true) {
      updateListView();
    } else {
      const Text('No Notes to Show');
    }
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: personList!.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.grey,
          elevation: 4.0,
          child: ListTile(
            leading: CircleAvatar(
              child: Image.asset('assets/photo.jpg'),
            ),
            title: Text(
              personList![index].name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            subtitle: Text(
              personList![index].age.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: GestureDetector(
              child: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              onTap: () {
                NavigatorToDetail(personList![index]);
              },
            ),
          ),
        );
      },
    );
  }
}
