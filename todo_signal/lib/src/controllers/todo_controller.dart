import 'package:signals/signals.dart';
import 'package:todo_signal/src/models/todo_model.dart';

class TodoController {
  final todos = <TodoModel>[].toSignal();

  //fica ouvindo, sempre que houver uma mudança no todo, ele atualiza o status
  late final Computed<String> todoStatusString = computed(() {
    final notCompleted = todos.where((todo) => !todo.completed);

    if (todos.isEmpty) {
      return 'Não há tarefas';
    } else if (notCompleted.isEmpty) {
      return 'Todas as tarefas foram concluídas';
    }
    return '${notCompleted.length} tarefas não concluídas';
  });

  Future<void> addTodo(TodoModel todo) async {
    todos.add(todo);
  }

  Future<void> removeTodo(TodoModel todo) async {
    todos.removeWhere((todoList) => todoList.id == todo.id);
  }

  Future<void> editTodo(TodoModel todoUp) async {
    //itera sobre a lista de todos, quando chega no que quer editar, ele faz o copyWith e muda o parametro que quer
    //senao ele retorna o todo normal e transforma em lista pq no map vira um iterable
    todos.value = todos.map((todo) {
      if (todo.id == todoUp.id) {
        return todo.copyWith(completed: !todo.completed);
      }
      return todo;
    }).toList();
  }
}
