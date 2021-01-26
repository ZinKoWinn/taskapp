enum AppTab {
  todos,
  stats,
}

enum VisibilityFilter {
  showAll,
  showActive,
  showCompleted,
}

enum ExtraAction {
  markAllCompleted,
  clearCompleted,
}

typedef TodoUpdater = void Function(
  Object todo, {
  String id,
  String title,
  String note,
  bool complete,
});
