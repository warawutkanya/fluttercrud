import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class EditTaskPage extends StatelessWidget {
  final TaskController taskController = Get.find();
  final int index;

  EditTaskPage({required this.index});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: taskController.taskList[index].title);
    final TextEditingController descriptionController =
        TextEditingController(text: taskController.taskList[index].description);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                taskController.updateTask(
                  index,
                  Task(
                    title: titleController.text,
                    description: descriptionController.text,
                  ),
                );
                Get.back();
              },
              child: Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}
