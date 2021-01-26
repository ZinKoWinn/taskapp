class TodoEntity {
  String id;
  String title;
  String note;
  bool complete;

  TodoEntity({
    this.id,
    this.title,
    this.note,
    this.complete,
  });
  static TodoEntity fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      complete: json['complete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "note": note,
      "complete": complete,
    };
  }

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ note.hashCode ^ complete.hashCode;

      
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          note == other.note &&
          complete == other.complete;

  @override
  String toString() {
    return "TodoEntity()";
  }
}
