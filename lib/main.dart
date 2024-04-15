import 'package:flutter/material.dart';
import 'package:todo_app/task_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo',
      home: TaskPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Task> tasks = [];

  void addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].toggleDone();
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                tasks[index].title,
                style: TextStyle(
                    decoration: tasks[index].isDone
                        ? TextDecoration.lineThrough
                        : null),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_forever_sharp),
                onPressed: () => {deleteTask(index)},
              ),
              onTap: () => {toggleTask(index)},
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //addTask('Test');
          showDialog(
            context: context,
            builder: (context) {
              var myController = TextEditingController();

              return AlertDialog(
                title: const Text("Add new Task"),
                content: TextField(controller: myController),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (myController.text.isNotEmpty) {
                        addTask(myController.text);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 18, 162, 229),
        child: const Icon(Icons.add),
      ),
    );
  }
}
