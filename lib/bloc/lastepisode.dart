import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webstreaming/Network/Api.dart';
import 'package:webstreaming/rout/rout_const.dart';
import 'package:webstreaming/widget/lastepisode.dart';
import 'package:webstreaming/view/main.dart';

class lastepsiode extends StatefulWidget {
  @override
  lastepsiodestate createState() => new lastepsiodestate();
}
class lastepsiodestate extends State<lastepsiode> {
  List datalastepisode;
  List data;
  Map<String, dynamic> map;
  bool loading = true;
  int _currentmaxvalue = 0;
  ScrollController _scrollController = ScrollController();
   String urlnextpage;
  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<String> getData() async {
    var response =
    await http.get(ApimainUrl+"lastepisode"+UrlToken+homeState.Token);
    this.setState(() {
      map = json.decode(response.body);
      datalastepisode = map['lastepisodes']['data'];
      _currentmaxvalue= map['lastepisodes']['per_page'];
      urlnextpage = map['lastepisodes']['next_page_url'];
      if(datalastepisode.length>0){
        setState(() {
          loading = false;
        });
      }
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if(urlnextpage!=null) {
            _getMoreData(urlnextpage+UrlToken+homeState.Token);
          }
        }
      });
    });


  }
    _getMoreData(String Url) async {
      var response =
          await http.get(Url);
      this.setState(() {
        map = json.decode(response.body);
        print(map['lastepisodes']['data']);
        datalastepisode.addAll(map['lastepisodes']['data']);
        _currentmaxvalue= _currentmaxvalue+ map['lastepisodes']['per_page'];
        urlnextpage = map['lastepisodes']['next_page_url'];
      });
    }
  Widget build(BuildContext context) {
    return   Stack(
      children: <Widget>[
        ListView.builder(
            controller: _scrollController,
            itemCount: _currentmaxvalue+1,
            itemBuilder: (BuildContext context, int index) {
             if(_currentmaxvalue == index && _currentmaxvalue!=0 ){
             return  Center(child: CircularProgressIndicator());
             }else if(_currentmaxvalue == 0) {
               return Container();
             }
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, player_const,arguments: '${datalastepisode[index]["id"]}');
                },
                child: lastepisode(
                  image: datalastepisode[index]["posts"]["images"][0]["url"],
                  Titel: datalastepisode[index]["posts"]["Titel"],
                  date: datalastepisode[index]["created_at"],
                  episode: datalastepisode[index]["episode"],
                  langue: datalastepisode[index]["langue"]
                 ),
              );
            }),
        Visibility(
    child: Center(child: CircularProgressIndicator()),
    visible: loading,
    )
      ],


    );
  }
}
