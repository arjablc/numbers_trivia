import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecaase.dart';
import '../../../../core/utils/number_converver.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';
import '../../domain/usecases/get_specified_number_trivia.dart';

part 'numbertrivia_event.dart';
part 'numbertrivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetRandomNumberTrivia random;
  final GetSpecifiedNumberTrivia specified;
  final NumberUtil util;

  NumberTriviaBloc(
      {required this.util, required this.random, required this.specified})
      : super(NumberTriviaInitial()) {
    on<GetSpecifiedNumberTriviaEvent>(
      (event, emit) async {
        if (event.input.isEmpty) {
          return emit(
              const NumberTriviaErrorState(message: "Please Enter a Number"));
        }
        final parsedNumberOrFailure = util.convertToNumber(event.input);
        await parsedNumberOrFailure.fold(
            (left) async => emit(const NumberTriviaErrorState(
                message: AppString.invalidInputFailureMessage)), (right) async {
          emit(NumberTriviaLoadingState());
          final triviaOrFailure = await specified(param: Param(number: right));
          await triviaOrFailure.fold(
              (l) async => emit(NumberTriviaErrorState(
                  message: l.errorMessage ?? _mapFailureToMessage(l))),
              (r) async => emit(NumberTriviaLoadedState(trivia: r)));
        });
      },
    );
    on<GetRandomNumberTriviaEvent>((event, emit) async {
      emit(NumberTriviaLoadingState());
      final triviaOrFailure = await random(param: NoParam());
      debugPrint(triviaOrFailure.toString());
      triviaOrFailure.fold(
          (l) => emit(NumberTriviaErrorState(
              message: l.errorMessage ?? _mapFailureToMessage(l))),
          (r) => emit(NumberTriviaLoadedState(trivia: r)));
    });
  }
  String _mapFailureToMessage(Failure failure) {
    return switch (failure.runtimeType) {
      ServerFailure _ => AppString.serverFailureMessage,
      LocalFailure _ => AppString.cacheFailureMessage,
      _ => 'something went very wrong',
    };
  }
}
