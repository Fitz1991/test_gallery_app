import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_gallery_app/view/card_image.dart';
import 'package:test_gallery_app/model/gallery_image.dart';

import '../block/gallery/gallery_bloc/gallery_bloc.dart';
import '../block/gallery/gallery_navigation_bloc/navigation_bloc.dart';

class GalleryPage extends StatelessWidget {
  List<GalleryImage> images;
  ScrollController _scrollController;
  int pageNo = 1;
  int maxPages;

  @override
  Widget build(BuildContext context) {
    double scrollPosition = BlocProvider.of<GalleryBloc>(context)
        .prefs
        ?.getDouble('scroll_position');
    _scrollController = ScrollController(
        initialScrollOffset: (scrollPosition != null) ? scrollPosition : 0);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if ((pageNo + 1) <= maxPages) {
          pageNo++;
          BlocProvider.of<GalleryBloc>(context).add(LoadImages(page: pageNo));
        }
      }
    });
    return Scaffold(
      appBar: AppBar(title: Text('Галлерея')),
      body: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          if (state is GalleryInitial) {
            return Text('Loading...');
          }
          if (state is GalleryLoaded) {
            maxPages = state.maxPages;
            return ListView.builder(
              itemCount: state.images.length,
              itemBuilder: (context, index) {
                return _cardImage(state, context, index);
              },
              controller: _scrollController,
            );
          } else {
            return Text('Что-то пошло не так...');
          }
        },
      ),
    );
  }

  Widget _cardImage(GalleryLoaded state, BuildContext context, int index) {
    return CardImage(
      () => BlocProvider.of<GalleryBloc>(context)
          .add(LikeGallery(state.images[index])),
      isLiked: state.images[index].iSLiked,
      onNavigate: () {
        BlocProvider.of<GalleryBloc>(context)
            .add(SaveScrollPosition(_scrollController.position.pixels));
        BlocProvider.of<NavigationBloc>(context)
            .add(NavigateToFullScreen(state.images[index]));
      },
      urlImage: state.images[index].url,
    );
  }
}
