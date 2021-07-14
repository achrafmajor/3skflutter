
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webstreaming/Network/Api.dart';
import 'package:webstreaming/bloc/vertical_List.dart';
import 'package:webstreaming/view/main.dart';
import 'package:webstreaming/variable.dart';

class schedule extends StatefulWidget {
  @override
  Schedulestate createState() => new Schedulestate();
}

class Schedulestate extends State<schedule> {
  Map map;
  List days,data;
  List datamovie;

  Future<String> getData() async {
    var response = await http.get(ApimainUrl+"schedule"+UrlToken+homeState.Token);
    map = jsonDecode(response.body);
    days = map['schedule'];
    return 'true';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.black,
       appBar: AppBar(title: Text('$schedule_variable'), centerTitle: true,),
      body: FutureBuilder(
          initialData: Container(
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          future: getData(),
          builder: (context, snapshot) {
            if (days == null) {
              return Container(
                child: Center(child: CircularProgressIndicator()),);
            } else {
              return ListView.builder(
                itemCount: days.length ,
                itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[

                    verticalList(
                      data: map['schedule'][index]['posts'],
                      Titel: days[index]['day'],
                    ),

                  ],
                );
              },

              );
            }
          }
      ),
    );
  }
}
