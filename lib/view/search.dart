import 'package:flutter/material.dart';
import 'package:webstreaming/Network/Api.dart';
import 'package:webstreaming/bloc/listgrid.dart';
import 'package:webstreaming/rout/rout_const.dart';
import 'package:http/http.dart' as http;
import 'package:webstreaming/variable.dart';
import 'dart:async';
import 'dart:convert';
import 'package:webstreaming/view/main.dart';

import 'package:webstreaming/widget/mainitem.dart';
class search extends StatefulWidget {

  @override
  searchState createState() => new searchState();
}
class searchState extends State<search>{
  String keyword =keywordforintsearch;
  Map<String, dynamic> map;
  bool loading = true;
  int _currentmaxvalue = 0;
  ScrollController _scrollController = ScrollController();
  String urlnextpage;
  List data;
  @override
  controller(value) {
    setState(() {

      keyword = value;
      data.clear();
      _currentmaxvalue = 0;
      getData(keyword);
    });
  }




  @override
  void initState() {
    super.initState();
    getData(keyword);
  }

  Future<String> getData(String keyword) async {
    var response =
    await http.get(ApimainUrl+'livesearch/'+keyword+UrlToken+homeState.Token);
    this.setState(() {
      map = json.decode(response.body);
      data = map['Posts']['data'];
      _currentmaxvalue = data.length;
      urlnextpage = map['Posts']['next_page_url'];
      if (data.length > 0) {
        setState(() {
          loading = false;
        });
      }
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (urlnextpage != null) {
            print(urlnextpage+UrlToken.replaceAll('?', '&')+homeState.Token);
            _getMoreData(urlnextpage+UrlToken.replaceAll('?', '&')+homeState.Token);
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
      print(map['Posts']['data']);
      data.addAll(map['Posts']['data']);
      _currentmaxvalue = _currentmaxvalue + (data.length-_currentmaxvalue);
      urlnextpage = map['Posts']['next_page_url'];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text(search_variable),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.black,
          child: Column
            (
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(

                    onChanged: (value) => {
                       print(value),
                      controller(value)
                    },
                    style: TextStyle(fontSize: 20,color: Colors.white),
                    autofocus: false,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      filled: true,
                      hintText: "$search_variable",
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
              Expanded(child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: MediaQuery.of(context).size.width /
                      MediaQuery.of(context).size.height ,),

                  controller: _scrollController,
                  itemCount: _currentmaxvalue+1,
                  itemBuilder: (BuildContext context, int index) {
                    if(_currentmaxvalue == index && _currentmaxvalue!=0 ){
                      if(urlnextpage!=null){
                        return  Center(child: CircularProgressIndicator());
                      }
                      return Container();

                    }else if(_currentmaxvalue == 0) {
                      return Container();
                    }
                    return item(Titel: data[index]['Titel'],Image: data[index]['images'][0]["url"],ID:'${data[index]["id"]}');

                  })) ,
            ],
          ),
        ),
      ) ,
    );
  }
}
