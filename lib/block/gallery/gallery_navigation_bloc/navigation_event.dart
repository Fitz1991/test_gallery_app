part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class NavigateToGallery extends NavigationEvent {}

class NavigateToFullScreen extends NavigationEvent {
  GalleryImage galleryImage;

  NavigateToFullScreen(this.galleryImage);
}
