part of 'likes_bloc.dart';


@immutable
abstract class LikesState {}

class LikesInitialState extends LikesState {
}

class LikesIncrementState extends LikesState{
  final Map<int,int> dataList;
  LikesIncrementState(this.dataList);
}

class LikesDecrementState extends LikesState{
  final Map<int,int> dataList;
  LikesDecrementState(this.dataList);
}

class LikesErrorState extends LikesState{}



