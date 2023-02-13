import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_practice/Repository/user_repository.dart';
import 'package:bloc_practice/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _repository;

  HomeBloc(this._repository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async{
      emit(UserLoadingState());
      print('Loading...');
      try{
        final user = await _repository.getUserData();
        emit(UserLoadedState(user));
      }catch(e){
        emit(UserErrorState(e.toString()));
      }
    });

  }
}
