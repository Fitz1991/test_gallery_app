part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {}

class GalleryPageState extends NavigationState {}

class FullScreenPageState extends NavigationState {
  GalleryImage galleryImage;

  FullScreenPageState(this.galleryImage);
}
