import 'package:contacts_crud_flutter/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: FutureBuilder(
          future: getContacts(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(snapshot.data?[index]['uid']),
                    onDismissed: (direction) {
                      deleteContact(snapshot.data?[index]['uid']);
                      snapshot.data?.removeAt(index);
                    },
                    background: Container(
                      color: Colors.red,
                      child: const Icon(Icons.delete),
                    ),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      bool result = false;
                      result = await showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: Text(
                                  "¿Estás seguro de eliminar el contacto de ${snapshot.data?[index]['name']}"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    return Navigator.pop(context, false);
                                  },
                                  child: const Text("Cancelar"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    return Navigator.pop(context, true);
                                  },
                                  child: const Text("Si"),
                                ),
                              ],
                            );
                          }));
                      return result;
                    },
                    child: ListTile(
                      title: Text(snapshot.data?[index]['name']),
                      onTap: () async {
                        await Navigator.pushNamed(context, '/edit', arguments: {
                          "uid": snapshot.data?[index]['uid'],
                          "name": snapshot.data?[index]['name'],
                        });
                        setState(() {});
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
