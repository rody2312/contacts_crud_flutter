import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;


//Obtener lista de contactos
Future<List> getContacts() async {
  List contacts = [];
  CollectionReference collectionReferenceContacts = firestore.collection('contacts');

  QuerySnapshot queryContact = await collectionReferenceContacts.get();

  for (var doc in queryContact.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {
      "uid" : doc.id,
      "name" : data["name"],
    };
    contacts.add(person);
  }

  return contacts;
}


//Guardar contacto en la base de datos
Future<void> addContact(String name) async {
  await firestore.collection("contacts").add({"name": name});
}


//Actualizar contacto en la base de datos
Future<void> updateContact(String uid, String name) async {
  await firestore.collection("contacts").doc(uid).set({'name': name});
}


//Borrar contacto en la base de datos
Future<void> deleteContact(String uid) async {
  await firestore.collection("contacts").doc(uid).delete();
}