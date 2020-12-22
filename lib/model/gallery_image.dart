class GalleryImage{

  String id;
  String farm_id;
  String server_id;
  String secret;

  String title;
  bool iSLiked;

  GalleryImage.fromJson(Map<String, dynamic> jsonImage) :
        id = jsonImage['id'],
        farm_id = jsonImage['farm'].toString(),
        server_id = jsonImage['server'],
        secret = jsonImage['secret'],
        title = jsonImage['title'],
        iSLiked = false;

  String get url => 'https://farm$farm_id.staticflickr.com/$server_id/${id}_$secret.jpg';
}