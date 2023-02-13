part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable{}

class UserLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends HomeState{
  final List<UserModel> userData;
  UserLoadedState(this.userData);

  @override
  List<Object?> get props => [userData];
}

class UserErrorState extends HomeState{
  final String error;

  UserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
