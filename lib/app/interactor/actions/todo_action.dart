import '/app/injector.dart';

import '../atoms/todo_atom.dart';
import '../models/todo_model.dart';

import '../repository/todo_repository.dart';

Future<void> fetchTodos() async {
  final repository = injector.get<TodoRepository>();

  todoState.value = await repository.getTAll();
}

Future<void> saveTodo(TodoModel model) async {
  final repository = injector.get<TodoRepository>();

  if (model.id == null) {
    await repository.insert(model);
  } else {
    await repository.update(model);
  }

  fetchTodos();
}

Future<void> deleteTodo(int id) async {
  final repository = injector.get<TodoRepository>();
  await repository.delete(id);
  fetchTodos();
}
