import 'package:flutter/material.dart';
import 'package:taskapp/src/core/data/repo/todo-repo.dart';
import 'package:taskapp/src/core/presentation/data/todo-model.dart';
import 'package:taskapp/src/core/presentation/provider/app-model.dart';
import 'package:taskapp/src/core/utils/enum/app-enum.dart';

class TodoProvider extends StatefulWidget {
  final Widget child;
  final AppState state;
  final TodosRepository todosRepository;
  const TodoProvider({
    Key key,
    this.child,
    this.state,
    this.todosRepository,
  }) : super(key: key);

  @override
  TodoProviderState createState() => TodoProviderState();

  static TodoProviderState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_StateInheritance>().data;
  }
}

class TodoProviderState extends State<TodoProvider> {
  AppState state;

//load data
  @override
  void initState() {
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = AppState.isLoading();
    }

    widget.todosRepository.fetchTodos().then((loadedTodos) {
      setState(() {
        state = AppState(
            todos: loadedTodos
                .map((entity) => TodoModel.fromEntity(entity))
                .toList());
      });
    });
    super.initState();
  }

//create

  @override
  void setState(VoidCallback fn) {
    widget.todosRepository
        .saveTodo(state.todos.map((e) => e.toEntity()).toList());
    super.setState(fn);
  }

//update

  void toggleAll() {
    setState(() {
      state.toggleAll();
    });
  }

  void clearCompleted() {
    setState(() {
      state.removeComplete();
    });
  }

  void addTodo(TodoModel todoModel) {
    setState(() {
      state.todos.add(todoModel);
    });
  }

  void removeTodo(TodoModel todoModel) {
    setState(() {
      state.todos.remove(todoModel);
    });
  }

//filter

  void updateFilter(VisibilityFilter filter) {
    setState(() {
      state.activeFilter = filter;
    });
  }

  void updateTodo(
    TodoModel todo, {
    String id,
    String title,
    String note,
    bool complete,
  }) {
    setState(() {
      todo.id = id ?? todo.id;
      todo.title = title ?? todo.title;
      todo.note = note ?? todo.note;
      todo.complete = complete ?? todo.complete;
    });
  }

//todos

  @override
  Widget build(BuildContext context) {
    return _StateInheritance(
      child: widget.child,
      data: this,
    );
  }
}

class _StateInheritance extends InheritedWidget {
  final TodoProviderState data;

  _StateInheritance({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(
          key: key,
          child: child,
        );
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
