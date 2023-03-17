import 'package:flutter/material.dart';
import '../../domain/entities/trivia_entity.dart';

class TriviaDisplay extends StatelessWidget {
  final TriviaEntity triviaEntity;

  const TriviaDisplay({
    Key? key,
    required this.triviaEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
          // Fixed size, doesn't scroll
          Text(
            triviaEntity.number.toString(),
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Expanded makes it fill in all the remaining space
          Expanded(
            child: Center(
              // Only the trivia "message" part will be scrollable
              child: SingleChildScrollView(
                child: Text(
                  triviaEntity.text,
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
