import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_practice/Repository/image_repository.dart';
import 'package:bloc_practice/image_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository _repository;
  ImageBloc(this._repository) : super(ImageInitialState()) {
    on<LoadImageEvent>((event, emit) async{
      emit(ImageInitialState());
      try{
        final data = await _repository.getImgData();
        emit(ImageLoadedState(data));
      }catch(e){
        emit(ImageErrorState(e.toString()));
      }

    });
  }
}
