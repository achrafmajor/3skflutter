import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webstreaming/Network/Api.dart';
import 'package:webstreaming/bloc/lastepisode.dart';
import 'package:webstreaming/bloc/listgrid.dart';
import 'package:webstreaming/variable.dart';
import 'package:webstreaming/view/main.dart';


class recentreleas extends StatefulWidget {
  @override
  recentreleasState createState() => new recentreleasState();
}

class recentreleasState extends State<recentreleas> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Recent_relaese),
          backgroundColor: Colors.black,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: Episodes_variable,
              ),
              Tab(
                text:  Serie,
              ),
              Tab(
                text: movie,
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            lastepsiode(),
            listgrid(url: ApimainUrl+'serielist'+UrlToken+homeState.Token,),
            listgrid(url: ApimainUrl+'movielist'+UrlToken+homeState.Token,),

          ],
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
