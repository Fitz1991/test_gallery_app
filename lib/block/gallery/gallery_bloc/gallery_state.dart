part of 'gallery_bloc.dart';

@immutable
abstract class GalleryState {}

class GalleryInitial extends GalleryState {}

class GalleryLoaded extends GalleryState {
  List<GalleryImage> images;
  int maxPages;

  GalleryLoaded({this.images, this.maxPages});
}

class GalleryLoading extends GalleryState {}

class GalleryLoadError extends GalleryState {}
