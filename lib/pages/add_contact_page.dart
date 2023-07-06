import 'package:contacts_crud_flutter/services/firebase_service.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {

  TextEditingController nameController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
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
              await addContact(nameController.text).then((_) {
                Navigator.pop(context);
              });
            }, child: Text("Guardar"))
          ],
        ),
      ),
    );
  }
}