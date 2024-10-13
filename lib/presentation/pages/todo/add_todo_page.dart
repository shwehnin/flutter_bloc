import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/pages/todo/cubit/todo_cubit.dart';

class AddTodoPage extends StatelessWidget {
  final TextEditingController todoTitleController = TextEditingController();
  AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: todoTitleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TodoCubit>().addTodo(
                      todoTitleController.text.trim(),
                    );
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
