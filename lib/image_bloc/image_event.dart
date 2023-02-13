part of 'image_bloc.dart';

@immutable
abstract class ImageEvent extends Equatable{}

class LoadImageEvent extends ImageEvent{
  @override
  List<Object?> get props => [];
}
