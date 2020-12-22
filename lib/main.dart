import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_gallery_app/domain/gallery/gallery_bloc.dart';
import 'package:test_gallery_app/full_screen.dart';

import 'gallery_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (routeSettings){
        var path = routeSettings.name.split('/');

        if (path[1] == "full_screen") {
          return new MaterialPageRoute(
            builder: (context) => FullScreen(),
            settings: routeSettings,
          );
        } else{
          return new MaterialPageRoute(
            builder: (context) => MyHomePage(),
            settings: routeSettings,
          );
        }
      },
      title: 'Test gallery app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
      MultiBlocProvider(
        providers: [
          BlocProvider<GalleryBloc>(create: (context) =>
          GalleryBloc()
            ..add(LoadImages(page: 1))),
        ],
        child: MyHomePage(title: 'Test gallery app'),
      )
      ,
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

