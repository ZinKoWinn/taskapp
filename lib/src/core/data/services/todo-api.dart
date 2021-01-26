//api fetch and save

import 'package:taskapp/src/core/data/entity/todo-entity.dart';
import 'package:taskapp/src/core/data/repo/todo-repo.dart';

class TodoAPI implements TodosRepository {
  final Duration delay;

  const TodoAPI([this.delay = const Duration(microseconds: 5000)]);
  //http.get
  @override
  Future<List<TodoEntity>> fetchTodos() {
    return Future.delayed(
      delay,
      () => [
        TodoEntity(
          id: "1",
          title: "Doctor Appointment",
          note:
              "You placed gold on my finger You brought love like I've never knownYou gave life to our children And to me a reason to go on",
          complete: false,
        ),
        TodoEntity(
          id: "2",
          title: "Studio Appointment",
          note:
              "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur.",
          complete: false,
        ),
        TodoEntity(
          id: "3",
          title: "Studio Appointment",
          note:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          complete: true,
        ),
        TodoEntity(
          id: "4",
          title: "Flutter Online Class ",
          note:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          complete: false,
        ),
      ],
    );
  }

//http.put
  @override
  Future saveTodo(List<TodoEntity> todos) {
    return Future.value(true);
  }
}
