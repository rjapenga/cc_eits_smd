import 'package:flutter/material.dart';

class CCArticlesInherit extends StatefulWidget {
  final List<bool> checkbox;
  const CCArticlesInherit({super.key, required this.checkbox});
  @override
  State<CCArticlesInherit> createState() => CCArticlesInheritState();
}

class CCArticlesInheritState extends State<CCArticlesInherit> {
  int numberRead = 0;
  void updateProgress(bool isChecked) {
    setState(() {
      numberRead += isChecked ? 1 : -1;
    });
  }

  void toggleCheckbox(int i) {
    setState(() {
      widget.checkbox[i] = !widget.checkbox[i];
    });
  }

  List<String> taskLabel = [
    'Embedded in Thin Slices',
    'Technology Features',
    'Datasheets',
    'From the Bench',
    'Picking Up Mixed Signals',
    'Embedded Systems Essentials',
    'The Magic Smoke Factory',
    'Product News',
    'Feature Article #1',
    'Feature Article #2',
    'Feature Article #3',
    'Feature Article #4',
    'Feature Article #5',
    'Feature Article #6',
    'Feature Article #7',
    'Feature Article #8',
    'Feature Article #9',
    'Feature Article #10',
    'Feature Article #11',
    'Feature Article #12',
    'Feature Article #13',
    'Feature Article #14',
  ];
  List<TaskItem> tasks = List<TaskItem>.empty(growable: true);
  @override
  initState() {
    super.initState();
    for (int i = 0; i < taskLabel.length; i++) {
      tasks.add(TaskItem(label: taskLabel[i], index: i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TaskInherited(
        numberRead: numberRead,
        updateProgress: updateProgress,
        toggleCheckbox: toggleCheckbox,
        checkbox: widget.checkbox,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Circuit Cellar Planner w/ InhertedWidgets'),
            titleTextStyle: const TextStyle(fontSize: 16, color: Colors.red),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Progress(tasksLength: tasks.length),
                TaskList(tasks: tasks),
              ],
            ),
          ),
        ));
  }
}

class TaskInherited extends InheritedWidget {
  final int numberRead;
  final List<bool> checkbox;
  final void Function(bool) updateProgress;
  final void Function(int) toggleCheckbox;
  const TaskInherited({
    super.key,
    required this.numberRead,
    required this.updateProgress,
    required this.toggleCheckbox,
    required this.checkbox,
    required super.child,
  });

  static TaskInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>()!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return numberRead != oldWidget.numberRead;
  }
}

class Progress extends StatelessWidget {
  final int tasksLength;

  const Progress({super.key, required this.tasksLength});
  @override
  Widget build(BuildContext context) {
    double progress = TaskInherited.of(context).numberRead / tasksLength;

    return Column(
      children: [
        const Text('Reading Progress:'),
        LinearProgressIndicator(
            value: progress,
            borderRadius: BorderRadius.circular(4.0),
            minHeight: 30.0),
        Text('Total Read: ${TaskInherited.of(context).numberRead}'),
        Text('${(progress * 100).toStringAsFixed(0)}% completed'),
      ],
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.tasks});
  final List<Widget> tasks;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: tasks,
    );
  }
}

class TaskItem extends StatefulWidget {
  final String label;
  final int index;
  const TaskItem({super.key, required this.label, required this.index});

  @override
  TaskItemState createState() => TaskItemState();
}

class TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final inheritedData = TaskInherited.of(context);
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.greenAccent,
          activeColor: Colors.red,
          onChanged: (newValue) {
            inheritedData.toggleCheckbox(widget.index);
            inheritedData.updateProgress(newValue!);
          },
          value: TaskInherited.of(context).checkbox[widget.index],
        ),
        Text(widget.label),
      ],
    );
  }
}
