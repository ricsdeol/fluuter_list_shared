import '../models/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getTAll();
  Future<TodoModel> insert(TodoModel todo);
  Future<TodoModel> update(TodoModel todo);
  Future<bool> delete(int id);
}
