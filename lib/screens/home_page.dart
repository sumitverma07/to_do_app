import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constant/color.dart';
import 'package:to_do_app/cubit/todo_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController todoController = TextEditingController();
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('To do App'),
      ),
      body: Column(
        children: [
          TextField(
            controller: todoController,
            decoration: InputDecoration(
              hintText: 'Enter Some Task',
            ),
          ),
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search Your Task',
              prefixIcon: Icon(Icons.search, color: tdBlack),
            ),
            onChanged: (query) {
              context.read<TodoCubit>().searchTodos(query);
            },
          ),
          Expanded(child:
              BlocBuilder<TodoCubit, List<String>>(builder: (context, todos) {
            return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        context.read<TodoCubit>().removeTodoAt(index);
                      },
                    ),
                  );
                });
          })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final value = todoController.text;
          if (value.isNotEmpty) {
            context.read<TodoCubit>().addTodo(value);
            todoController.clear();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
