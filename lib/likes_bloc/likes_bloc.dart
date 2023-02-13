import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'likes_event.dart';

part 'likes_state.dart';

class LikesBloc extends Bloc<LikesEvent, LikesState> {
  int index = 0;
  int likesCounter = 0;
  int temp = 0;
  Map<int, int> likesList = {};

  LikesBloc() : super(LikesInitialState()) {
    on<IncrementEvent>((event, emit) {
      // index++;
      index = event.likesIndex;
      if (likesList.containsKey(index)) {
        temp = likesList[index]!;
        likesList[index] = temp + 1;
      } else {
        likesList[index] = 1;
      }
      try {
        emit(LikesIncrementState(likesList));
      } catch (e) {
        throw 'Error in Increment ${e.toString()}';
      }
    });

    on<DecrementEvent>((event, emit) {
      index = event.likesIndex;
      if (likesList.containsKey(index)) {
        temp = likesList[index]!;
        likesList[index] = temp - 1;
      } else {
        likesList[index] = 0;
      }
      try {
        emit(LikesDecrementState(likesList));
      } catch (e) {
        throw 'Error in Decrement ${e.toString()}';
      }
    });
  }
}
