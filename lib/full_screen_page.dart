import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_gallery_app/block/gallery/full_screen_bloc/full_screen_bloc.dart';
import 'package:test_gallery_app/card_image.dart';
import 'package:test_gallery_app/model/gallery_image.dart';

import 'block/gallery/gallery_navigation_bloc/navigation_bloc.dart';

class FullScreen extends StatelessWidget {
  GalleryImage galleryImage;
  SharedPreferences prefs;

  FullScreen({this.galleryImage}) {
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${galleryImage.title}'),
      ),
      body: BlocBuilder<FullScreenBloc, FullScreenState>(
        builder: (context, state) {
          if (state is Liked) {
            return _cardImage(context);
          } else
            return _cardImage(context);
        },
      ),
    );
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();
    galleryImage.iSLiked = (prefs.getBool(galleryImage.id) != null)
        ? prefs.getBool(galleryImage.id)
        : false;
  }

  Widget _cardImage(BuildContext context) {
    return WillPopScope(
      child: CardImage(
          () => BlocProvider.of<FullScreenBloc>(context)
              .add(LikeImage(galleryImage)),
          isLiked: galleryImage.iSLiked,
          urlImage: galleryImage.url),
      onWillPop: () {
        BlocProvider.of<NavigationBloc>(context).add(NavigateToGallery());
        return;
      },
    );
  }
}
