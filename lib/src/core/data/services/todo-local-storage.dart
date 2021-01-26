import 'dart:convert';
import 'package:taskapp/src/core/data/entity/todo-entity.dart';
import 'package:taskapp/src/core/data/repo/todo-repo.dart';
import 'package:key_value_store/key_value_store.dart';

class LocalStorage implements TodosRepository {
  //name for our data
  final String key;
  final KeyValueStore store;
  final JsonCodec codec;

  LocalStorage({this.key, this.store, this.codec = json});
  @override
  Future<List<TodoEntity>> fetchTodos() {
    return codec
        .decode(store.getString(key))['todos']
        .cast<Map<String, dynamic>>()
        .map<TodoEntity>(TodoEntity.fromJson)
        .toList(growable: false);
  }

  @override
  Future saveTodo(List<TodoEntity> todos) {
    final value =
        codec.encode({"todos": todos.map((todo) => todo.toJson()).toList()});
    return store.setString(key, value);
  }
}
