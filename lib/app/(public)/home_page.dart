import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import '../interactor/actions/todo_action.dart';
import '../interactor/models/todo_model.dart';

import '../interactor/atoms/todo_atom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  void editTodoDialog([TodoModel? model]) {
    model ??= TodoModel(title: '', check: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Todo'),
          content: TextFormField(
            initialValue: model?.title,
            onChanged: (value) {
              model = model!.copyWith(title: value);
            },
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.cancel, color: Colors.grey)),
            TextButton(
                onPressed: () {
                  deleteTodo(model!.id!);
                  Navigator.pop(context);
                },
                child: const Icon(Icons.delete, color: Colors.red)),
            TextButton(
                onPressed: () {
                  saveTodo(model!);
                  Navigator.pop(context);
                },
                child: const Icon(Icons.add, color: Colors.blue)),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(builder: (_) {
      final todos = todoState.value;

      return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (_, index) {
              final todo = todos[index];

              return GestureDetector(
                onLongPress: () {
                  editTodoDialog(todo);
                },
                child: CheckboxListTile(
                  value: todo.check,
                  title: Text(todo.title),
                  onChanged: (value) {
                    final todo = todos[index];
                    saveTodo(todo.copyWith(check: value!));
                  },
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: editTodoDialog,
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
