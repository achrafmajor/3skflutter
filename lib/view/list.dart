
import 'package:flutter/material.dart';
import 'package:webstreaming/bloc/listgrid.dart';
import 'package:webstreaming/variable.dart';
class list extends StatelessWidget {
   final String Listname;
   final  String Listapisub;
   final  String Listapidub;
  const list({Key key, this.Listname, this.Listapisub,this.Listapidub}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Listname),
          backgroundColor: Colors.black,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: sub,
              ),
              Tab(
                text: dub,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            listgrid(url: Listapisub,),
            listgrid(url: Listapidub,),
          ],
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
