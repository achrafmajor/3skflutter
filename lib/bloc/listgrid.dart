import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webstreaming/Network/Api.dart';
import 'package:webstreaming/widget/lastepisode.dart';
import 'package:webstreaming/widget/mainitem.dart';
import 'package:webstreaming/view/main.dart';

class listgrid extends StatefulWidget {
  final String url;

  const listgrid({Key key, this.url}) : super(key: key);

  @override
  listgridstate createState() => new listgridstate();
}

class listgridstate extends State<listgrid> {
  List data;
  Map<String, dynamic> map;
  bool loading = true;
  bool _isloading = true;
  int _currentmaxvalue = 0;
  ScrollController _scrollController = ScrollController();
  String urlnextpage;
   Future future;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<String> getData() async {
    var response = await http.get(widget.url);
    this.setState(() {
      map = json.decode(response.body);
      data = map['Posts']['data'];
      if (map['Posts']['per_page'] != null) {
        _currentmaxvalue = map['Posts']['per_page'];
        urlnextpage = map['Posts']['next_page_url'];
      }else{
        _currentmaxvalue=data.length-1;
      }

      if (data.length > 0) {
        loading = false;
        _isloading = false;
      }
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (urlnextpage != null) {
            _getMoreData(urlnextpage+UrlToken.replaceAll('?', '&')+homeState.Token);
          }
        }
      });
    });
  }

  _getMoreData(String Url) async {
    var response = await http.get(Url);
    this.setState(() {
      map = json.decode(response.body);
      print(map['Posts']['data']);
      data.addAll(map['Posts']['data']);
      _currentmaxvalue = _currentmaxvalue + (data.length - _currentmaxvalue);
      urlnextpage = map['Posts']['next_page_url'];
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        FutureBuilder(future: future,
          builder: (context, snapshot) {
          if(map==null){
            return Visibility(
                visible: _isloading,
                child: Container(
                  child: Center(child: CircularProgressIndicator()),
                ));
          }else{
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      MediaQuery.of(context).size.height,
                ),
                controller: _scrollController,
                itemCount: _currentmaxvalue + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (data.length==0) {
                    return Container();
                  }else if (_currentmaxvalue == index && _currentmaxvalue != 0 && urlnextpage!=null) {
                    return Center(child: CircularProgressIndicator());
                  } else if (_currentmaxvalue != index && _currentmaxvalue == 0 && urlnextpage==null) {
                    return Container();
                  }
                 else if (data.length == index  && urlnextpage==null) {
                   return Container();
                }
                  return item(
                      Titel: data[index]['Titel'],
                      Image: data[index]['images'][0]["url"],
                      ID: '${data[index]["id"]}');
                });
          }

        },)
      ],
    );
  }
}
