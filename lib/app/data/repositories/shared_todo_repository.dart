import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../adapter/todo_adapter.dart';
import '../../interactor/models/todo_model.dart';
import '../../interactor/repository/todo_repository.dart';

const _key = 'TODO_LIST';

class SharedTodoRepository implements TodoRepository {
  @override
  Future<List<TodoModel>> getTAll() async {
    final list = await _getList();
    return list.map((e) => TodoAdapter.fromMap(e)).toList();
  }

  @override
  Future<TodoModel> insert(TodoModel todo) async {
    final list = await _getList();

    final id = list.isEmpty ? 1 : list.last['id'] + 1;

    final newModel = todo.copyWith(id: id);

    list.add(TodoAdapter.toMap(newModel));

    _updateList(list);
    return newModel;
  }

  @override
  Future<TodoModel> update(TodoModel todo) async {
    final list = await _getList();
    final index = list.indexWhere((element) => element['id'] == todo.id);

    if (index == -1) throw Exception('Todo not found');
    list[index] = TodoAdapter.toMap(todo);

    _updateList(list);

    return todo;
  }

  @override
  Future<bool> delete(int id) async {
    final list = await _getList();
    final index = list.indexWhere((element) => element['id'] == id);

    if (index == -1) throw Exception('Todo not found');

    list.removeAt(index);

    _updateList(list);

    return true;
  }

  Future<List> _getList() async {
    final shared = await SharedPreferences.getInstance();
    final json = shared.getString(_key) ?? '[]';

    return jsonDecode(json).toList();
  }

  Future<void> _updateList(List list) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString(_key, jsonEncode(list));
  }
}
