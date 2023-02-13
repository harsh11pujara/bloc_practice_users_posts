part of 'image_bloc.dart';

@immutable
abstract class ImageState extends Equatable{}

class ImageInitialState extends ImageState {
  @override
  List<Object?> get props => [];
}

class ImageLoadedState extends ImageState {
  final List<ImageModel> data;

  ImageLoadedState(this.data);
  @override
  List<Object?> get props => [data];
}

class ImageErrorState extends ImageState {
  final String error;

  ImageErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
