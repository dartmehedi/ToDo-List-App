import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khalid_bin_flutter/Models/todo_model.dart';
import 'package:khalid_bin_flutter/Provider/todo_provider.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();

  Future<void> _showDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('add todo List'),
            content: TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: "write to Items "),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                  onPressed: () {
                    if (_textController.text.isEmpty) {
                      return;
                    }
                    context.read<TodoProvider>().addTodoList(
                          TODOModel(
                              title: _textController.text, isCompleted: false),
                        );
                    _textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Submit"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xff622CA7),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    )),
                child: const Center(
                  child: Text(
                    "TO DO List",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemBuilder: (context, itemIndex) {
                  return ListTile(
                    onTap: () {
                      provider
                          .todoStatusChange(provider.allTODOList[itemIndex]);
                    },
                    leading: MSHCheckbox(
                      size: 30,
                      value: provider.allTODOList[itemIndex].isCompleted,
                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                        checkedColor: Colors.blue,
                      ),
                      style: MSHCheckboxStyle.stroke,
                      onChanged: (selected) {
                        provider
                            .todoStatusChange(provider.allTODOList[itemIndex]);
                      },
                    ),
                    title: Text(
                      provider.allTODOList[itemIndex].title,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          decoration:
                              provider.allTODOList[itemIndex].isCompleted ==
                                      true
                                  ? TextDecoration.lineThrough
                                  : null),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        provider.removeToDoList(provider.allTODOList[itemIndex]);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
                itemCount: provider.allTODOList.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        backgroundColor: const Color(0xff622CA7),
        child: Icon(Icons.add),
      ),
    );
  }
}
