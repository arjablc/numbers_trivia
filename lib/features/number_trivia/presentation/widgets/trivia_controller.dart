import 'package:clean_architecture/core/extensiosn/context_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/numbertrivia_bloc.dart';
import 'package:flutter/material.dart';

class TriviaControl extends StatefulWidget {
  const TriviaControl({
    super.key,
  });

  @override
  State<TriviaControl> createState() => _TriviaControlState();
}

class _TriviaControlState extends State<TriviaControl> {
  final TextEditingController _controller = TextEditingController();
  String inputStr = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          style: context.textTheme.displaySmall!.copyWith(fontFamily: 'none'),
          keyboardType: const TextInputType.numberWithOptions(),
          decoration: const InputDecoration(
            labelText: 'Enter a number',
          ),
          onChanged: (value) => inputStr = value,
          onSubmitted: (value) => context.read<NumberTriviaBloc>()
            ..add(
              GetSpecifiedNumberTriviaEvent(input: value),
            ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => addGetSpecificEvent(inputStr),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 8, 0, 12),
                  child: Center(child: Text('Search')),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextButton(
                onPressed: () => addGetRandomEvent(),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 8, 0, 12),
                  child: Center(child: Text('Get Random')),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void addGetSpecificEvent(String input) {
    debugPrint(input.isEmpty.toString());
    _controller.clear();
    context
        .read<NumberTriviaBloc>()
        .add(GetSpecifiedNumberTriviaEvent(input: inputStr));
  }

  void addGetRandomEvent() {
    _controller.clear();
    context.read<NumberTriviaBloc>().add(GetRandomNumberTriviaEvent());
  }
}
