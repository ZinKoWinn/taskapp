import 'package:flutter/material.dart';
import 'package:taskapp/src/core/presentation/data/todo-model.dart';
import 'package:taskapp/src/core/presentation/provider/todo-provider.dart';
import 'package:taskapp/src/core/utils/constants/app-key.dart';
import 'package:taskapp/src/feature/screens/todos/widgets/todo-item.dart';

import '../todo-detail.dart';

class TodoList extends StatelessWidget {
  TodoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = TodoProvider.of(context);

    return Container(
      child: _buildList(provider),
      //If you want to add loading you can add
      // child: provider.state.isLoading ? _buildLoading : _buildList(provider),
    );
  }

  Center get _buildLoading {
    return Center(
      child: CircularProgressIndicator(
        key: AppKeys.todosLoading,
      ),
    );
  }

  ListView _buildList(TodoProviderState container) {
    final todos = container.state.filterTodos;

    return ListView.builder(
      key: AppKeys.todoList,
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final todo = todos[index];

        return TodoItem(
          todo: todo,
          onDismissed: (direction) {
            _removeTodo(context, todo);
          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return DetailScreen(
                    todo: todo,
                  );
                },
              ),
            ).then((todo) {
              if (todo is TodoModel) {
                _showUndoSnackbar(context, todo);
              }
            });
          },
          onCheckboxChanged: (complete) {
            container.updateTodo(todo, complete: !todo.complete);
          },
        );
      },
    );
  }

  void _removeTodo(BuildContext context, TodoModel todo) {
    TodoProvider.of(context).removeTodo(todo);
    _showUndoSnackbar(context, todo);
  }

  void _showUndoSnackbar(BuildContext context, TodoModel todo) {
    final snackBar = SnackBar(
      key: AppKeys.snackbar,
      duration: Duration(seconds: 2),
      content: Text(
        todo.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      action: SnackBarAction(
        key: AppKeys.snackbarAction(todo.id),
        label: "Undo",
        onPressed: () {
          TodoProvider.of(context).addTodo(todo);
        },
      ),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
