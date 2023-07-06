import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;


//Obtener lista de contactos
Future<List> getContacts() async {
  List contacts = [];
  CollectionReference collectionReferenceContacts = firestore.collection('contacts');

  QuerySnapshot queryContact = await collectionReferenceContacts.get();

  queryContact.docs.forEach((doc) {
    contacts.add(doc.data());
  });

  return contacts;
}


//Guardar contacto en la base de datos
Future<void> addContact(String name) async {
  await firestore.collection("contacts").add({"name": name});
}