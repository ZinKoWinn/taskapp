//communicate with service and database

import 'package:taskapp/src/core/presentation/data/todo-model.dart';
import 'package:taskapp/src/core/utils/enum/app-enum.dart';

class AppState {
  //loading  for data
  final bool isLoading;
  final List<TodoModel> todos;
  VisibilityFilter activeFilter = VisibilityFilter.showAll;

  AppState({
    this.isLoading,
    this.todos = const [],
    this.activeFilter = VisibilityFilter.showAll,
  });

  factory AppState.isLoading() => AppState(isLoading: true);

  //fetch all completed todos
  bool get getAllCompleted => todos.every((todo) => todo.complete);

  // get all completed todos
  bool get hasCompletedTodos => todos.any((todo) => todo.complete);

//fetch filtered data

  List<TodoModel> get filterTodos => todos.where((todo) {
        switch (activeFilter) {
          case VisibilityFilter.showActive:
            return !todo.complete;
            break;
          case VisibilityFilter.showCompleted:
            return todo.complete;
            break;
          default:
            return true;
        }
      }).toList();

  int get numActive =>
      todos.fold(0, (sum, todo) => !todo.complete ? ++sum : sum);

  int get numComplete =>
      todos.fold(0, (sum, todo) => todo.complete ? ++sum : sum);

  void removeComplete() {
    todos.removeWhere((todo) => todo.complete);
  }

  void toggleAll() {
    final allCurrentCompleted = getAllCompleted;
    todos.forEach((todo) => todo.complete = !allCurrentCompleted);
  }

  @override
  int get hashCode => isLoading.hashCode ^ todos.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          todos == other.todos;

  @override
  String toString() {
    return "TodoEntity()";
  }
}
