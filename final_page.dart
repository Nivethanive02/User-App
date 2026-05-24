
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:quiz_app/question_data.dart';

class FinalPage extends StatefulWidget {
  final List<bool> answeredQuestions;
  const FinalPage({super.key, required this.answeredQuestions});
  

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
 final ConfettiController confettiController =ConfettiController();

 @override
 void initState(){
  confettiController. launch();
  super.initState();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(height: 200),
            Text("Quiz Completed!",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            ),
            Text("Total Questions: ${questionsData.length}",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            ),
            Text("Correct Answer:${widget.answeredQuestions.length}",
            ),
            ElevatedButton(onPressed: (){
              confettiController.launch();
            },
             child: Text("Click"),
            ),
            Expanded(
              child: Confetti(
              instant:true,
              controller:confettiController,
              options:ConfettiOptions(particleCount:150,gravity :0.3),
            ),
            ),
          ],
        ),
      )
    );
  }
}

