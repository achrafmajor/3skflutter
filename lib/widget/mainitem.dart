import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:webstreaming/rout/rout_const.dart';

class item extends StatelessWidget {
  final String Titel;
  final String Image;
  final String ID;
  const item({Key key, this.Titel, this.Image, this.ID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, show_const,arguments: ID);
        },
        child: Column(
          children: <Widget>[

            Container(
              height: 150,
              width: 110,
              child: Stack(
                children: <Widget>[
                  Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black))),
                  FadeInImage.assetNetwork(
                    placeholder: 'lib/images/asfalt-light.png',
                    image: Image,
                    fit: BoxFit.cover,
                    height: 150,
                    width: 110,
                  )
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.white,

              ),
            ),
            Container(
              width:110 ,
              child: Center(
                child:
                AutoSizeText(
                  Titel,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 13,
                  maxLines:1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
