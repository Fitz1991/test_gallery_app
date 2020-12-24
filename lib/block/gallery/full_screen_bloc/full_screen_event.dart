part of 'full_screen_bloc.dart';

@immutable
abstract class FullScreenEvent {}

class LikeImage extends FullScreenEvent {
  GalleryImage galleryImage;

  LikeImage(this.galleryImage);
}
