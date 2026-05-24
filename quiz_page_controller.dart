import 'package:flutter/material.dart';
import 'package:quiz_app/question_data.dart';
import 'package:quiz_app/quiz_page.dart';

class QuizPageController extends StatefulWidget {
  const QuizPageController({super.key});

  @override
  State<QuizPageController> createState() => _QuizPageControllerState();
}

class _QuizPageControllerState extends State<QuizPageController> {
  final pageController = PageController();
 List<bool> answeredQuestions =[]; 
 

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: questionsData.length,
      itemBuilder: (context, index) => QuizPage(
        question: questionsData[index],
        currentIndex: index,
        pageController: pageController,
        answeredQuestions:answeredQuestions,
      ),
    );
  }
}
