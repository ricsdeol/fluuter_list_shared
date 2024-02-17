import 'package:auto_injector/auto_injector.dart';
import 'data/repositories/shared_todo_repository.dart';
import 'interactor/repository/todo_repository.dart';

final injector = AutoInjector();

void registerDependencies() {
  injector.add<TodoRepository>(SharedTodoRepository.new);
}
