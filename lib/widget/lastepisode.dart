

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../variable.dart';


class lastepisode extends StatelessWidget {

  final String Titel;
  final String date;
  final String view;
  final String episode;
  final String image;
  final String langue;
  const lastepisode({Key key, this.Titel, this.date, this.view, this.episode, this.image, this.langue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.010),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)) ,
        color: Colors.grey[900],
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Stack(
              children: <Widget>[
                Center(child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.black),)),
                FadeInImage.assetNetwork(
                  placeholder: 'lib/images/asfalt-light.png',
                  image: image,
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

            width: MediaQuery.of(context).size.width * 0.55,
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AutoSizeText(
                  Titel,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,fontWeight: FontWeight.bold),
                  minFontSize: 13,
                  maxLines:3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(Jiffy(date).fromNow(),

                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,fontWeight: FontWeight.bold)
                    ),
                   /* Row(children: <Widget>[
                      Icon(Icons.remove_red_eye,color: Colors.grey,size: 15,),
                      Text('12.5K',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,fontWeight: FontWeight.bold,))
                    ],

                    )*/
                  ],
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,

            decoration: BoxDecoration(
                border: Border(right: BorderSide(width: 2))
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 1,horizontal: 4),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8)
                            ,color: Colors.blue
                        ),
                        child: AutoSizeText(
                          langue,
                          style: TextStyle(color: Colors.white,fontSize: 14,),
                          minFontSize: 9,
                          maxLines:1,

                        ),
                      ) ,
                      Icon(Icons.play_circle_outline,color: Colors.white,size: 50,),

                      AutoSizeText(
                        "$Episode:"+episode,
                        style: TextStyle(color: Colors.white,fontSize: 14,),
                        minFontSize: 9,
                        maxLines:1,
                      )
                    ],
                  ),
                )

              ],
            ),

          )

        ],
      ),
    );
  }


}
