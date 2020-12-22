import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_gallery_app/domain/gallery/gallery_bloc.dart';
import 'package:test_gallery_app/model/gallery_image.dart';

class GalleryPage extends StatelessWidget {
  List<GalleryImage> images;
  ScrollController _scrollController = ScrollController();
  int pageNo = 1;
  int maxPages;

  GalleryPage();
  
  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if ((pageNo + 1) <= maxPages) {
          pageNo++;
          BlocProvider.of<GalleryBloc>(context).add(LoadImages(page: pageNo));
        }
      }
    });
    return  BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          if(state is GalleryInitial){
            return Text('Loading...');
          }
          if(state is GalleryLoaded){
            maxPages = state.maxPages;
            return ListView.builder(
              itemCount: state.images.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: Image.network(state.images[index].url, fit: BoxFit.cover,)),
                        ),
                      ),
                      SvgPicture.asset('assets/heart-solid.svg')
                    ],
                  ),
                );
              },
              controller: _scrollController,
            );
          }
          else{
            return Text('Что-то пошло не так...');
          }
        },
      );
  }

}
