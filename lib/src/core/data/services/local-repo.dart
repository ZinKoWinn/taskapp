import 'package:taskapp/src/core/data/entity/todo-entity.dart';
import 'package:taskapp/src/core/data/repo/todo-repo.dart';
import 'package:taskapp/src/core/data/services/todo-api.dart';

class TodoLocalRepo implements TodosRepository {
  final TodosRepository todosAPI;
  final TodosRepository localStorage;

  TodoLocalRepo({this.todosAPI = const TodoAPI(), this.localStorage});
  @override
  Future<List<TodoEntity>> fetchTodos() async {
    //localFetch

    try {
      return await localStorage.fetchTodos();
    } catch (e) {
   //fetch From API
      final todos = await todosAPI.fetchTodos();
      localStorage.saveTodo(todos);
      return todos;
    }
  }

  @override
  Future saveTodo(List<TodoEntity> todos) {
    return Future.wait([
      localStorage.saveTodo(todos),
      todosAPI.saveTodo(todos),
    ]);
  }
}
