import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/models/task_model.dart';

class TaskProviders extends ChangeNotifier {
  final Box<TaskModel> _taskBox = Hive.box<TaskModel>('taskBox');

  List<TaskModel> get tasks => _taskBox.values.toList();

  void addTask(TaskModel task) {
    _taskBox.add(task);
    notifyListeners();
  }

  void deleteTask(TaskModel task) {
    _taskBox.delete(task);
    notifyListeners();
  }

  void toggleComplete(TaskModel task) {
    task.isCompleted = !task.isCompleted;
    task.save();
    notifyListeners();
  }

  List<TaskModel> getAllTasks() {
    return _taskBox.values.toList();
  }
}
