import 'package:flutter/material.dart';
import 'package:todo_signal/src/models/todo_model.dart';
import 'package:todo_signal/src/pages/todo_screen.dart';

class AddTodoDialogWidget extends StatefulWidget {
  const AddTodoDialogWidget({super.key});

  @override
  State<AddTodoDialogWidget> createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final titleEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void onAddTodo() {
    if (formKey.currentState!.validate()) {
      final addTodo = TodoModel(
        titleEC.text,
        descriptionC: descriptionEC.text,
      );

      controller.addTodo(addTodo);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleEC,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: descriptionEC,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onAddTodo,
              child: const Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
