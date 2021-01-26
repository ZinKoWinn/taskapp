import 'package:flutter/material.dart';
import 'package:taskapp/src/core/presentation/data/todo-model.dart';
import 'package:taskapp/src/core/presentation/provider/todo-provider.dart';
import 'package:taskapp/src/core/utils/constants/app-key.dart';

class AddEditScreen extends StatefulWidget {
  final TodoModel todo;

  AddEditScreen({
    Key key,
    this.todo,
  }) : super(key: key ?? AppKeys.addTodoScreen);
  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title;
  String _note;

  @override
  Widget build(BuildContext context) {
    final provider = TodoProvider.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "edit Todo" : "add Todo",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.todo.title : '',
                key: AppKeys.taskField,
                autofocus: !isEditing,
                style: Theme.of(context).textTheme.headline6,
                decoration: InputDecoration(
                  hintText: "Task Name",
                ),
                validator: (val) {
                  return val.trim().isEmpty ? "Can not be Empty" : null;
                },
                onSaved: (value) => _title = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.todo.note : '',
                key: AppKeys.noteField,
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: "Some Description for Task",
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: isEditing ? AppKeys.saveTodoFab : AppKeys.saveNewTodo,
        tooltip: isEditing ? "saveChanges " : "addTodo",
        child: Icon(isEditing ? Icons.check : Icons.check),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();

            if (isEditing) {
              provider.updateTodo(widget.todo, title: _title, note: _note);
            } else {
              provider.addTodo(TodoModel(
                _title,
                note: _note,
              ));
            }

            Navigator.pop(context);
          }
        },
      ),
    );
  }

  bool get isEditing => widget.todo != null;
}
