import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_gallery_app/model/gallery_image.dart';

part 'full_screen_event.dart';

part 'full_screen_state.dart';

class FullScreenBloc extends Bloc<FullScreenEvent, FullScreenState> {
  FullScreenBloc() : super(FullScreenInitial()) {
    init();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences prefs;
  bool isLiked;

  @override
  Stream<FullScreenState> mapEventToState(
    FullScreenEvent event,
  ) async* {
    if (event is LikeImage) {
      yield* _likeImage(event.galleryImage);
    }
  }

  bool isLike(String id) {
    return prefs.getBool(id);
  }

  Stream<FullScreenState> _likeImage(GalleryImage galleryImage) async* {
    if (prefs.getBool(galleryImage.id) != null) {
      isLiked = prefs.getBool(galleryImage.id);
      prefs.setBool(galleryImage.id, !isLiked);
      galleryImage.iSLiked = !isLiked;
    } else {
      isLiked = await prefs.setBool(galleryImage.id, true);
      galleryImage.iSLiked = isLiked;
    }

    yield Liked(galleryImage);
  }
}
