import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:webstreaming/variable.dart';


class showgalery extends StatefulWidget {

  final List data;

  const showgalery({Key key, this.data}) : super(key: key);

  @override
  _showgaleryState createState() => new _showgaleryState(data);
}

class _showgaleryState extends State<showgalery> {
  final List data;
  int currentIndex= 0;

  _showgaleryState(this.data);

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(data[index]["url"]),
                  initialScale: PhotoViewComputedScale.contained * 0.8,

                );
              },
              itemCount: data.length,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                  ),
                ),
              ),
              onPageChanged: onPageChanged,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.white,),
                borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "$Image_variable ${currentIndex+1  }"+"/${data.length}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,

                ),
              ),
            )
          ],
        )
    );
  }
}