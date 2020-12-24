import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_gallery_app/block/gallery/full_screen_bloc/full_screen_bloc.dart';
import 'package:test_gallery_app/view/full_screen_page.dart';

import 'block/gallery/gallery_bloc/gallery_bloc.dart';
import 'block/gallery/gallery_navigation_bloc/navigation_bloc.dart';
import 'view/gallery_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test gallery app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<GalleryBloc>(
              create: (context) => GalleryBloc()..add(LoadImages(page: 1))),
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(),
          ),
          BlocProvider<FullScreenBloc>(
            create: (context) => FullScreenBloc(),
          )
        ],
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        if (state is GalleryPageState) {
          return GalleryPage();
        }
        if (state is FullScreenPageState) {
          return FullScreen(
            galleryImage: state.galleryImage,
          );
        } else {
          return GalleryPage();
        }
      },
    );
  }
}
