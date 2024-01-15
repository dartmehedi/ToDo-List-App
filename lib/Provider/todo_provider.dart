import 'package:flutter/material.dart';

import '../Models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<TODOModel> _todoList = [];

  List<TODOModel> get allTODOList => _todoList;

  void addTodoList(TODOModel todoModel) {
    _todoList.add(todoModel);
    notifyListeners();
  }

  void todoStatusChange(TODOModel todoModel)  {
    final index = _todoList.indexOf(todoModel);
    _todoList[index].toggleCompleted();
    notifyListeners();
  }

  void removeToDoList(TODOModel todoModel) {
    final index = _todoList.indexOf(todoModel);
    _todoList.removeAt(index);
    notifyListeners();
  }
}
