import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../controllers/todo_controller.dart';
import 'widgets/add_todo_dialog_widget.dart';

final controller = TodoController();

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo List Signal',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => const AddTodoDialogWidget(),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Watch((context) {
          return Column(
            children: [
              Center(
                child: Text(
                  controller.todoStatusString.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.todos.length,
                  itemBuilder: (_, int index) {
                    final todo = controller.todos[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: todo.completed
                            ? Colors.green[100]
                            : Colors.red[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: Checkbox(
                          value: todo.completed,
                          onChanged: (_) {
                            controller.editTodo(todo);
                          },
                        ),
                        title: Text(
                          todo.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          todo.description ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            controller.removeTodo(todo);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
