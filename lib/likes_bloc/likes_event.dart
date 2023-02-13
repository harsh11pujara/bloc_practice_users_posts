part of 'likes_bloc.dart';

@immutable
abstract class LikesEvent {}

class IncrementEvent extends LikesEvent{
  final int likesIndex ;

  IncrementEvent(this.likesIndex){
    print('${likesIndex}increment');
  }
}

class DecrementEvent extends LikesEvent{
  final int likesIndex ;

  DecrementEvent(this.likesIndex){
    print('${likesIndex}decrement');
  }
}
