import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_gallery_app/domain/gallery/gallery_bloc.dart';

import 'gallery_page.dart';

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
      home: BlocProvider<GalleryBloc>(create: (context) =>
      GalleryBloc()
        ..add(LoadImages(page: 1)), child: MyHomePage(title: 'Test gallery app')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String title;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: GalleryPage()
    );
  }
}

