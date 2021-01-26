import 'package:flutter/material.dart';
import 'package:taskapp/src/core/data/entity/todo-entity.dart';
import 'package:taskapp/src/core/utils/constants/uuid.dart';

class TodoModel {
  String id;
  String title;
  String note;
  bool complete;

  TodoModel(
    this.title, {
    this.note = "",
    this.complete = false,
    String id,
  }) : id = id ?? Uuid().generateV4();

//from entity to model
  static TodoModel fromEntity(TodoEntity entity) {
    return TodoModel(
      entity.title,
      id: entity.id ?? Uuid().generateV4(),
      note: entity.note,
    );
  }

//model to entity

  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      note: note,
      complete: complete,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ note.hashCode ^ complete.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModel &&
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
