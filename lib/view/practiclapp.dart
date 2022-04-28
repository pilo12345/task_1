import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage extends StatefulWidget {
  const LocalStorage({Key? key}) : super(key: key);

  @override
  _LocalStorageState createState() => _LocalStorageState();
}

class _LocalStorageState extends State<LocalStorage> {
  final task = TextEditingController();

  Box<String>? todo1;

  @override
  void initState() {
    todo1 = Hive.box<String>('todo');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Text("Add Task"),
                    TextFormField(
                      controller: task,
                      decoration: InputDecoration(hintText: "Number"),
                    ),
                  ],
                ),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                    color: Colors.red,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await todo1!.put('${Random().nextInt(1000)}', task.text);
                      // await todo1!.put('${Random().nextInt(1000)}', fName.text);
                      Navigator.pop(context);
                    },
                    child: Text("Add"),
                    color: Colors.green,
                  )
                ],
              );
            },
          );
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: todo1!.listenable(),
        builder: (BuildContext context, Box<String> value, _) {
          return ListView.builder(
            itemCount: value.keys.length,
            itemBuilder: (context, index) {
              final key = value.keys.toList()[index];
              final value1 = value.get(key);
              return ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Column(
                                children: [
                                  Text("Add Task"),
                                  TextFormField(
                                    controller: task,
                                    decoration:
                                        InputDecoration(hintText: "Number"),
                                  ),
                                ],
                              ),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                  color: Colors.red,
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    await todo1!.put('$key', task.text);

                                    Navigator.pop(context);
                                  },
                                  child: Text("Update"),
                                  color: Colors.green,
                                )
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        await todo1!.delete(key);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
                leading: Text(value1!),
              );
            },
          );
        },
      ),
    );
  }
}
