import 'package:clean_architecture/core/service/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensiosn/context_extension.dart';
import '../bloc/numbertrivia_bloc.dart';
import '../widgets/message_display.dart';
import '../widgets/trivia_controller.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NumberTriviaBloc>(),
      child: Scaffold(
          backgroundColor: context.theme.colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: [
                      BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                        builder: (context, state) {
                          if (state is NumberTriviaInitial) {
                            return MessageDisplay(
                              isError: false,
                              child: Text('Start Searching!!',
                                  style: context.textTheme.displayLarge),
                            );
                          } else if (state is NumberTriviaLoadingState) {
                            return const MessageDisplay(
                              isError: false,
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is NumberTriviaLoadedState) {
                            return MessageDisplay(
                              isError: false,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(state.trivia.number.toString(),
                                        style: context.textTheme.displayLarge),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      state.trivia.text,
                                      style: context.textTheme.displaySmall,
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else if (state is NumberTriviaErrorState) {
                            return MessageDisplay(
                              isError: true,
                              child: Text(state.message,
                                  style: context.textTheme.displayLarge),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      //textfield
                      const TriviaControl()
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
