import 'package:get/get.dart';
import '../models/task_model.dart';

class TaskController extends GetxController {
  // Observable list of tasks
  var taskList = <Task>[].obs;

  // Create a new task
  void addTask(Task task) {
    taskList.add(task);
  }

  // Update an existing task
  void updateTask(int index, Task task) {
    taskList[index] = task;
  }

  // Delete a task
  void deleteTask(int index) {
    taskList.removeAt(index);
  }

  // Toggle the completion status of a task
  void toggleCompletion(int index, bool value) {
    taskList[index].isCompleted = value; // Update the completion status
    taskList.refresh(); // Refresh the observable list to reflect changes
  }
}
