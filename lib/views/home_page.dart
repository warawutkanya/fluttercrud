import 'package:crud/views/add_task_page.dart';
import 'package:crud/views/edit_task_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class HomePage extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CRUD',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0, // Removes shadow
        backgroundColor: Colors.white,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return ListView.builder(
            itemCount: taskController.taskList.length +
                1, // Including the Add task button
            itemBuilder: (context, index) {
              if (index == taskController.taskList.length) {
                // If it's the last item, show Add Task button
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => AddTaskPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          'Add task',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                // Otherwise, display a regular task
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: double.infinity, // Ensure it takes full width
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          // Toggle the completion status on tap
                          taskController.toggleCompletion(index,
                              !taskController.taskList[index].isCompleted);
                        },
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: taskController
                                  .taskList[index].isCompleted
                              ? Colors.green
                              : Colors.grey, // Change color based on completion
                          child: Icon(
                            taskController.taskList[index].isCompleted
                                ? Icons.check_circle_outline
                                : null, // Show check mark only if completed
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                      title: Text(
                        taskController.taskList[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            taskController.taskList[index].description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: 16, color: Colors.green),
                              SizedBox(width: 5),
                              Flexible(
                                // Use Flexible to prevent overflow
                                child: Text(
                                  DateFormat('yyyy-MM-dd HH:mm').format(
                                      taskController.taskList[index]
                                          .createdAt), // Format the date
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                  overflow:
                                      TextOverflow.ellipsis, // Handle overflow
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize:
                            MainAxisSize.min, // Use min to prevent overflow
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Get.to(() => EditTaskPage(index: index));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              taskController.deleteTask(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          );
        }),
      ),
    );
  }
}
