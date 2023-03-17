import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../bloc/trivia_bloc_bloc.dart';
import '../../../../injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaPage extends StatelessWidget {
  const TriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: BlocProvider(
        create: (_) => sl<TriviaBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Top half
                BlocBuilder<TriviaBloc, TriviaBlocState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return const MessageDisplay(
                        message: 'Start searching!',
                      );
                    } else if (state is Loading) {
                      return const LoadingWidget();
                    } else if (state is Loaded) {
                      return TriviaDisplay(
                        triviaEntity: state.triviaEntity,
                      );
                    } else if (state is Error) {
                      return MessageDisplay(
                        message: state.message,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),

                const SizedBox(height: 20),
                // Bottom half
                const TriviaControls()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    super.key,
  });

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputStr = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                onPressed: dispatchConcrete,
                child: const Text('Search'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: dispatchRandom,
                child: const Text('Get random trivia'),
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    // Clearing the TextField to prepare it for the next inputted number
    controller.clear();
    BlocProvider.of<TriviaBloc>(context).add(GetTriviaForConcrete(inputStr));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<TriviaBloc>(context).add(GetTriviaForRandom());
  }
}
