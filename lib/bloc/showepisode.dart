import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:webstreaming/Network/Api.dart';
import 'package:webstreaming/variable.dart';
import 'dart:async';
import 'dart:convert';
import 'package:webstreaming/view/main.dart';
import 'package:webstreaming/rout/rout_const.dart';
class showepisode extends StatefulWidget {
  final List data;
  final String id;
  const showepisode({Key key, this.data,this.id}) : super(key: key);
  @override
  showepisodeState createState() => showepisodeState(data,id);
}


class showepisodeState extends State<showepisode> {
  final List data;
  final String id;
  List datas;
  Map<String, dynamic> map;
  String keyword;
  Color favoritesColors;

  showepisodeState(this.data,this.id);

  controller(value) {
    data.clear();
    setState(() {

      keyword = value;

      livesearch(keyword,id);
    });
  }
  Future<String> livesearch(String Episode,String id) async {
    var response =
        await http.get(ApimainUrl+"$id/episodesearche/$Episode"+UrlToken+homeState.Token);

    setState(() {
      map = json.decode(response.body);

      data.addAll(map['episodedata'][0]['episodes']) ;

      print(id);
    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onChanged: (value) => {
                  controller(value)
                },
                style: TextStyle(fontSize: 20,color: Colors.white),
                autofocus: false,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  filled: true,
                  hintText: "$searche_for_Episode_ex",
                  hintStyle: TextStyle(color: Colors.white) ,
                  prefixIcon: Icon(Icons.search,color: Colors.white,),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                )),
          ),
          Expanded(child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return   GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, player_const,arguments: '${data[index]["id"]}');

                },
                child: Container(
                  color: Colors.grey[900],
                  margin: EdgeInsets.all(5.0),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('$Episode '+data[index]['episode'],style: TextStyle(color: Colors.white,fontSize: 15),),
                      Icon(Icons.play_circle_outline,color: Colors.white,)
                    ],
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
    
  }
}
