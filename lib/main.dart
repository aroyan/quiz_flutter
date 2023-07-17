import 'package:flutter/material.dart';
import 'package:quiz_app/questions_bank.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squizzically',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Squizzically'),
        ),
        body: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Icon> scoreKeeper = [];

  int questionNumber = 0;

  QuestionsBank questionsBank = QuestionsBank();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${questionNumber + 1} / ${questionsBank.question.length}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        questionsBank.question[questionNumber].questionText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: questionsBank.question.length != scoreKeeper.length,
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  setState(() {
                    // Check user answer
                    bool userAnswer =
                        questionsBank.question[questionNumber].questionAnswer;

                    // Add sfx when the answer is correct or wrong?
                    if (userAnswer == true) {
                      if (scoreKeeper.length != questionsBank.question.length) {
                        scoreKeeper.add(const Icon(
                          Icons.check,
                          color: Colors.green,
                        ));
                      }
                    } else {
                      if (scoreKeeper.length != questionsBank.question.length) {
                        scoreKeeper.add(const Icon(
                          Icons.close,
                          color: Colors.red,
                        ));
                      }
                    }

                    // Update to next question
                    if (questionNumber < questionsBank.question.length - 1) {
                      questionNumber++;
                    }
                  });
                },
                child: const Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: questionsBank.question.length != scoreKeeper.length,
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  setState(() {
                    // Check user answer
                    bool userAnswer =
                        questionsBank.question[questionNumber].questionAnswer;

                    if (userAnswer == false) {
                      if (scoreKeeper.length != questionsBank.question.length) {
                        scoreKeeper.add(const Icon(
                          Icons.check,
                          color: Colors.green,
                        ));
                      }
                    } else {
                      if (scoreKeeper.length != questionsBank.question.length) {
                        scoreKeeper.add(const Icon(
                          Icons.close,
                          color: Colors.red,
                        ));
                      }
                    }

                    // Update to next question
                    if (questionNumber < questionsBank.question.length - 1) {
                      questionNumber++;
                    }
                  });
                },
                child: const Text(
                  'False',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: questionsBank.question.length == scoreKeeper.length,
            child: ElevatedButton(
              onPressed: () {
                List<Icon> filteredScoreKeeper = scoreKeeper
                    .where((icon) => icon.icon == Icons.check)
                    .toList();
                // Show alert
                AlertDialog alert = AlertDialog(
                  title: const Text('You have answered all the questions!'),
                  content: Text(
                      'Your score is ${filteredScoreKeeper.length * 100 ~/ questionsBank.question.length}!'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          scoreKeeper.clear();
                          questionNumber = 0;
                        });
                        Navigator.pop(context, true);
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                );
                showDialog(
                    context: context, builder: (BuildContext context) => alert);
              },
              child: const Text("Reset Game"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: scoreKeeper,
            ),
          )
        ],
      ),
    );
  }
}
