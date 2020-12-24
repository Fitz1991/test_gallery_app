part of 'full_screen_bloc.dart';

@immutable
abstract class FullScreenState {}

class FullScreenInitial extends FullScreenState {}

class Liked extends FullScreenState {
  GalleryImage galleryImage;

  Liked(this.galleryImage);
}
