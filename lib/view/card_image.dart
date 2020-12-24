import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../generated/assets.dart';

class CardImage extends StatelessWidget {
  Function onLike;
  Function onNavigate;
  String urlImage;
  bool isLiked;

  CardImage(this.onLike, {this.onNavigate, this.urlImage, this.isLiked});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (onNavigate != null) onNavigate();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(
                      urlImage,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                onLike();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  Assets.assetsLike,
                  color: isLiked ? Colors.red : Colors.black26,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
