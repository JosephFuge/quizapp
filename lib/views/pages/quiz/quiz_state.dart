// import 'package:flutter/material.dart';
// import 'package:quizapp/services/models.dart';

/// Old way - Provider Package
/// See quiz_provider.dart for RiverPod implementation
// class QuizState with ChangeNotifier {
//   double _progress = 0.0;
//   Option? _selected;
//
//   final PageController _controller = PageController();
//
//   double get progress => _progress;
//   Option? get selected => _selected;
//   PageController get controller => _controller;
//
//   set progress(double value) {
//     _progress = value;
//     notifyListeners();
//   }
//
//   set selected(Option? option) {
//     if (_selected != option) {
//       _selected = option;
//       notifyListeners();
//     }
//   }
//
//   void nextPage() async {
//     await controller.nextPage(
//         duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
//   }
// }
