import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webstreaming/model/DataModel.dart';
import 'package:webstreaming/rout/rout_const.dart';
import 'package:webstreaming/widget/lastepisode.dart';
import 'package:webstreaming/widget/mainitem.dart';
class verticalList extends StatefulWidget {
  final List data;
  final String Titel;
  const verticalList({Key key, this.data,this.Titel}) : super(key: key);
  @override
  verticalistsState createState() => new verticalistsState(data,Titel);
}

class verticalistsState extends State<verticalList> {
  final List data;
  final String Titel;
  verticalistsState(this.data,this.Titel);
  Widget build(BuildContext context) {
    return   Wrap(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: Colors.white),
                child: Text(
                  Titel,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            height: 187,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                  return item(Titel:  data[index]["Titel"],Image: data[index]["images"][0]["url"],ID:'${data[index]["id"]}' ,);
                }

            ),
          ),
        ],
    );
  }

}
