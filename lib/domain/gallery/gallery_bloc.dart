import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_gallery_app/model/gallery_image.dart';
import 'package:http/http.dart' as http;

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryInitial());

  List<GalleryImage> _galleryImage = [];

  String apiUrl = '';

  @override
  Stream<GalleryState> mapEventToState(
    GalleryEvent event,
  ) async* {
    if(event is LoadImages){
      yield* _loadImages(event);
    }
    if(event is LoadingImages) yield GalleryLoading();
  }

  Stream<GalleryState> _loadImages(LoadImages event) async* {
    try{
      apiUrl = "https://www.flickr.com/services/rest/?method=flickr.galleries.getPhotos&per_page=${event.perPage}&page=${event.page}&api_key=003974ac0ee484e862499a91e282e359&gallery_id=66911286-72157647277042064&format=json&nojsoncallback=1";
      var response = await http.get(apiUrl);
      if(response.statusCode == 200){
        Map photos = json.decode(response.body)['photos'];
        List<GalleryImage> galleryImages = (photos['photo'] as List).map((i) =>
            GalleryImage.fromJson(i)).toList();
        int maxPages = photos['pages'];
        _galleryImage.addAll(galleryImages);
        yield GalleryLoaded(images: _galleryImage, maxPages: maxPages);
      } else{
        throw Exception();
      }
    }catch(e){
      yield GalleryLoadError();
    }
  }
}
