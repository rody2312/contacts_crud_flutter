import 'package:contacts_crud_flutter/services/firebase_service.dart';
import 'package:flutter/material.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({super.key});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {

  TextEditingController nameController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments['name'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el nombre'
              ),
            ),
            ElevatedButton(onPressed: () async {
              await updateContact(arguments['uid'], nameController.text).then((value) {
                Navigator.pop(context);
              });
            }, child: const Text("Guardar"))
          ],
        ),
      ),
    );
  }
}