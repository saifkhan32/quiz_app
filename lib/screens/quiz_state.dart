

  import 'package:flutter/material.dart';
import 'package:pro/services/models.dart';

class QuizState with ChangeNotifier
{
  double _progress = 0;
  Option? _selected;
   
  final PageController controller = PageController();

  double get progress => _progress;
  Option? get selected => _selected;

  set progress(double newValue){
    _progress = newValue;
    notifyListeners();

  }
  set selected(Option? newvalue)
  {
    _selected =  newvalue;
    notifyListeners();
  }
  void nextPage() async
  {
      await controller.nextPage(duration: const Duration(milliseconds: 500), 
      curve: Curves.easeOut);
  }
}