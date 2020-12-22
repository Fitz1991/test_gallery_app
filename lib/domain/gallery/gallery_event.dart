part of 'gallery_bloc.dart';

@immutable
abstract class GalleryEvent {}

class LoadingImages extends GalleryEvent{}

class LoadImages extends GalleryEvent{
 int perPage;
 int page;

 LoadImages({this.perPage = 10, this.page});
}