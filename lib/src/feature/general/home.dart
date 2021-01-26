import 'package:flutter/material.dart';
import 'package:taskapp/src/core/presentation/provider/todo-provider.dart';
import 'package:taskapp/src/core/presentation/widgets/extra-action-button.dart';
import 'package:taskapp/src/core/presentation/widgets/filter-button.dart';
import 'package:taskapp/src/core/utils/constants/app-key.dart';
import 'package:taskapp/src/core/utils/enum/app-enum.dart';
import 'package:taskapp/src/core/utils/routes/app-routes.dart';
import 'package:taskapp/src/feature/screens/states/state-counter.dart';
import 'package:taskapp/src/feature/screens/todos/widgets/todo-list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppTab activeTab = AppTab.todos;
  @override
  Widget build(BuildContext context) {
    final provider = TodoProvider.of(context);
    final state = provider.state;
    return Scaffold(
      appBar: AppBar(
        actions: [
          FilterButton(
            isActive: activeTab == AppTab.todos,
            activeFilter: state.activeFilter,
            onSelected: provider.updateFilter,
          ),
          ExtraActionsButton(
            allComplete: state.getAllCompleted,
            hasCompletedTodos: state.hasCompletedTodos,
            onSelected: (action) {
              if (action == ExtraAction.clearCompleted) {
                provider.toggleAll();
              } else if (action == ExtraAction.clearCompleted) {
                provider.clearCompleted();
              }
            },
          )
        ],
      ),
      body: activeTab == AppTab.todos ? TodoList() : StatsPage(),
      floatingActionButton: FloatingActionButton(
        key: AppKeys.addTodoFab,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.todo);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: AppKeys.tabs,
        currentIndex: AppTab.values.indexOf(activeTab),
        onTap: (index) {
          _updateTab(AppTab.values[index]);
        },
        items: AppTab.values.map((tab) {
          return BottomNavigationBarItem(
            icon: Icon(
              tab == AppTab.todos ? Icons.list : Icons.show_chart,
              key: tab == AppTab.stats ? AppKeys.statsTab : AppKeys.todoTab,
            ),
            label: tab == AppTab.stats ? "Stats" : "List",
          );
        }).toList(),
      ),
    );
  }

  void _updateTab(AppTab tab) {
    setState(() {
      activeTab = tab;
    });
  }
}
