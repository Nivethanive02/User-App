import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/final_page.dart';
import 'package:quiz_app/question_data.dart';


class QuizPage extends StatefulWidget {
  final Map<String, dynamic> question;
  final int currentIndex;
  final PageController pageController;
  List<bool> answeredQuestions;

  QuizPage(
    {
    super.key,
    required this.question,
    required this.currentIndex,
    required this.pageController, required this.answeredQuestions,
  }
  );

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String answer = "";
  int correctIndex = 0;
  bool isTheyClickedNext = false;
  Timer? timer;
  int seconds =120;
  String timerString = "02:00";
  
  @override
  void initState(){
    timer =Timer.periodic(
      Duration(seconds: 1),
      (timer) => changeTimerFromMinutesToSeconds(),
    );
    super.initState();
  }
  changeTimerFromMinutesToSeconds(){
    seconds--;
    if (seconds ==0){
      if (widget.currentIndex== questionsData.length-1){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>
          FinalPage( answeredQuestions: widget.answeredQuestions),
          ),
        );
      } else{
        widget.pageController.nextPage(
          duration: Duration(milliseconds: 500),
           curve: Curves.ease,
        );
      }
    }
    timerString = "0${seconds ~/ 60}:${(seconds % 60).toString()}";
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            if (widget.currentIndex == 0) {
              Navigator.of(context).pop();
            } else {
              widget.pageController.previousPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,  //animation
              );
            }
          },
          child: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.purple[100],
            ),
            child: Center(child: Icon(Icons.arrow_back_ios_new)),
          ),
        ),
        title: Text("Aptitude Test"),
        actions: [Icon(Icons.timer_sharp), Text(timerString.toString())],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Text(
            "Question ${widget.currentIndex + 1} of ${questionsData.length}",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
          ),
          SizedBox(height: 20),
          Text(
            widget.question["question"],
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: List.generate(
              4,
              (index) => Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color:
                        isTheyClickedNext &&
                            widget.question['answer'] ==
                                widget.question["options"][index]
                        ? Colors.green
                        : isTheyClickedNext &&
                              widget.question['answer'] !=
                                  widget.question["options"][index]
                        ? Colors.red
                        : answer == widget.question["options"][index]
                        ? Colors.black
                        : Colors.grey.shade400,
                  ),
                  color: answer == widget.question["options"][index]
                      ? Colors.purple[50]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Text(
                      widget.question["options"][index],
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Checkbox(
                      value: answer == widget.question["options"][index],
                      onChanged: (value) {
                        setState(() {
                          answer = widget.question["options"][index];
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () async {
              if (answer == "") return;
              setState(() {
                isTheyClickedNext = true;
              });
              await Future.delayed(Duration(seconds: 2));
              if (widget.currentIndex == questionsData.length - 1) {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) =>
                 FinalPage(answeredQuestions: widget.answeredQuestions),
                 ),
                 );
              } else {
                widget.pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              }
              // Navigator.of(
              //   context,
              // ).push(MaterialPageRoute(builder: (context) => QuizPage()));
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: isTheyClickedNext
                    ? CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      )
                    : Text(
                        "Next ->",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(height: 45),
        ],
      ),
    );
  }
}
