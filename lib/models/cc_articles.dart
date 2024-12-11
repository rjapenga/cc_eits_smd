import 'package:flutter/material.dart';
// It is not obvious to me where this is instantiated
// Is it in main.dart when I declare it is a ChangeNotifierProvider
// This class is used to provide the toggle function and the getter (checkbox)
// The getter function and notifyListener are built into Flutter
// The class has an array of booleans representing the status of the list of
//   articles read
// Every time the checkbox is toggled, we notify all listeners
// This happens with the onChanged callback in the Checkbox widget
// The MyApp Widget in main.dart sets up this class as a ChangeNotifierProvider
// I hate using this "magic number" of 22. How can I not do that?
// The following confuses me -
// context.watch<T>() listens to changes on T
// context.read<T>() returns T without listening to it
// T is a class - does that mean it listens to all instantiations of the class?

class CheckboxModel with ChangeNotifier {
  final List<bool> _checkbox = List.filled(22, false);
  List<bool> get checkbox => _checkbox;

  void toggle(int i) {
    _checkbox[i] = !_checkbox[i];
    notifyListeners();
  }
}

// This class is used for counting the number of articles read
class ReadCountModel with ChangeNotifier {
  int _numberRead = 0;
  // This is the getter function numberRead which returns _count
  int get numberRead => _numberRead;

  void increment() {
    _numberRead++;
    notifyListeners();
  }

  void decrement() {
    _numberRead--;
    notifyListeners();
  }
}
