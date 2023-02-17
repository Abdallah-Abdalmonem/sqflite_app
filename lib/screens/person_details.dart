import 'package:flutter/material.dart';
import 'package:sqlite_flutter/models/person.dart';

class PersonDetails extends StatefulWidget {
  const PersonDetails({super.key, required this.person});
  final Person person;
  @override
  State<PersonDetails> createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageControllter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.cyanAccent,
    );
  }
}
