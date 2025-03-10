
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/domain.dart';
import 'package:uuid/uuid.dart';

part 'todo_providers.g.dart';

enum FilterType { all, completed, pending }

const uuid = Uuid();

@Riverpod(keepAlive: true)
class TodoCurrentFilter extends _$TodoCurrentFilter {
  @override
  FilterType build() {
    return FilterType.all;
  }

  void setFilter(FilterType filter) {
    state = filter;
  }
}

@Riverpod(keepAlive: true)
class Todos extends _$Todos {
  @override
  List<Todo> build() {
    return [
      Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
      Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
      Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
      Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    ];
  }

  void toggleTodoStatus(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(
          completedAt: todo.done ? null : DateTime.now(),
        );
      }
      return todo;
    }).toList();
  }

  void createTodo(String description) {
    state = [
      ...state,
      Todo(
        id: uuid.v4(),
        description: description,
        completedAt: null,
      ),
    ];
  }

}

@riverpod
List<Todo> filterListTodo(Ref ref) {
  final currentFilter = ref.watch(todoCurrentFilterProvider);
  final todos = ref.watch(todosProvider);

  final filteredTodos = todos.where((todo) {
    switch (currentFilter) {
      case FilterType.completed:
        return todo.done;
      case FilterType.pending:
        return !todo.done;
      default:
        return true;
    }
  }).toList();

  return filteredTodos;
}