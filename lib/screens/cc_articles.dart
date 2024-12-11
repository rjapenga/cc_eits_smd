import 'package:flutter/material.dart';
// ****************************************************************************************
// The following are added to use the Provider Package for State Management.
// Provider is supposed to make State Management Easier
//
import 'package:provider/provider.dart';
import '../models/cc_articles.dart';

// This ends the provider specific stuff
// *****************************************************************************************
class CCArticles extends StatefulWidget {
  const CCArticles({super.key});

  @override
  State<CCArticles> createState() => _CCArticleState();
}

class _CCArticleState extends State<CCArticles> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circuit Cellar Planner w/ Providers'),
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
    );
  }
}

class Progress extends StatelessWidget {
  final int tasksLength;

  const Progress({super.key, required this.tasksLength});
  @override
  Widget build(BuildContext context) {
    double progress = context.watch<ReadCountModel>().numberRead / tasksLength;

    return Column(
      children: [
        const Text('Reading Progress:'),
        LinearProgressIndicator(
            value: progress,
            borderRadius: BorderRadius.circular(4.0),
            minHeight: 30.0),
        Text('Total Read: ${context.watch<ReadCountModel>().numberRead}'),
        Text('${(progress * 100).toStringAsFixed(0)}% Completed'),
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
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.greenAccent,
          activeColor: Colors.red,
          onChanged: (newValue) {
            newValue!
                ? context.read<ReadCountModel>().increment()
                : context.read<ReadCountModel>().decrement();
            context.read<CheckboxModel>().toggle(widget.index);
          },
          value: context.watch<CheckboxModel>().checkbox[widget.index],
        ),
        Text(widget.label),
      ],
    );
  }
}
