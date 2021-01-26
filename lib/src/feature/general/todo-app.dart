import 'package:flutter/material.dart';
import 'package:taskapp/src/core/utils/routes/app-routes.dart';
import 'package:taskapp/src/core/utils/style/app-style.dart';
import 'package:taskapp/src/feature/general/home.dart';
import 'package:taskapp/src/feature/screens/todos/todo-edit.dart';

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (c) => "Todo App",
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.home: (c) => HomePage(),
        AppRoutes.todo: (c) => AddEditScreen(),
      },
    );
  }
}
