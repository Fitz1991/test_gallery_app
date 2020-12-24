import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_gallery_app/model/gallery_image.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(GalleryPageState());

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is NavigateToGallery) {
      yield GalleryPageState();
    }
    if (event is NavigateToFullScreen) {
      yield FullScreenPageState(event.galleryImage);
    }
  }
}
