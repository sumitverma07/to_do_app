import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoCubit extends Cubit<List<String>> {
  List<String> allTodos = [];

  TodoCubit() : super([]) {
    loadTodos();
    print('loadTodos function called at runtime');
  }

  void addTodo(String value) {
    final updateTodos = List<String>.from(state);
    updateTodos.add(value);
    emit(updateTodos);
    saveTodos(updateTodos);
    allTodos = updateTodos; // Update the allTodos list
    print('List added successfully: $updateTodos');
    print('List saved: $updateTodos');
  }

  void removeTodoAt(int index) {
    final updateTodos = List<String>.from(state);
    updateTodos.removeAt(index);
    emit(updateTodos);
    saveTodos(updateTodos);
    allTodos = updateTodos; // Update the allTodos list
    print('List deleted successfully: $updateTodos');
  }

  void saveTodos(List<String> todoList) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList('todos', todoList);
  }

  void loadTodos() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final values = sp.getStringList('todos') ?? [];
    emit(values);
    allTodos = values; // Initialize the allTodos list
    print('List loaded successfully: $values');
  }

  void searchTodos(String query) {
    if (query.isEmpty) {
      emit(List<String>.from(allTodos)); // Emit all todos if the query is empty
      print('all todos printed $allTodos');
    } else {
      final filteredTodos = allTodos
          .where((todo) => todo.toLowerCase().contains(query.toLowerCase()))
          .toList();
      print('Filtered list: $filteredTodos');
      emit(filteredTodos); // Emit the filtered list
    }
  }
}
