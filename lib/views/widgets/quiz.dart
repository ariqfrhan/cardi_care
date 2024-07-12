import 'package:flutter/material.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      question: map['question'],
      options: List<String>.from(map['options']),
      correctAnswerIndex: map['correctAnswerIndex'],
    );
  }
}

class QuizQuestionWidget extends StatefulWidget {
  final QuizQuestion question;
  final ValueChanged<int> onAnswerSelected;

  const QuizQuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  @override
  _QuizQuestionWidgetState createState() => _QuizQuestionWidgetState();
}

class _QuizQuestionWidgetState extends State<QuizQuestionWidget> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question.question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...List.generate(widget.question.options.length, (index) {
          return RadioListTile<int>(
            value: index,
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
              widget.onAnswerSelected(value!);
            },
            title: Text(widget.question.options[index]),
          );
        }),
      ],
    );
  }
}
