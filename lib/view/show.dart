import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webstreaming/Network/Api.dart';
import 'package:webstreaming/bloc/showepisode.dart';
import 'package:webstreaming/bloc/showgalery.dart';
import 'package:webstreaming/bloc/showinfo.dart';
import 'package:http/http.dart' as http;
import 'package:webstreaming/variable.dart';
import 'package:webstreaming/view/main.dart';

class show extends StatefulWidget {
  final String id;

  const show({Key key, this.id}) : super(key: key);

  @override
  showState createState() => showState(id);
}

class showState extends State<show> {
  Future future;
  final String id;

  List data, dataimages, Category, Episodes;
  Map<String, dynamic> map;
  String rate,
      countlikes,
      countViews,
      commentcount,
      Titel,
      langue,
      type,
      description;
  int favoritstatut;
  String Image = '';
  Color favoritesColors;

  showState(this.id);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(id);
  }

  @override
  favorit() async {
    if (favoritstatut == 1) {
      var response = await http
          .get(ApimainUrl + "MyList/remove/$id" + UrlToken + homeState.Token);
      setState(() {
        favoritesColors = Colors.grey;
        favoritstatut = 0;
      });
      print(response.body);
    } else {
      var response = await http
          .get(ApimainUrl + "MyList/add/$id" + UrlToken + homeState.Token);
      setState(() {
        favoritesColors = Colors.red;
        favoritstatut = 1;

        print(response.body);
      });
    }
  }

  Future<String> getData(String id) async {
    var response =
        await http.get(ApimainUrl + "show/$id" + UrlToken + homeState.Token);
    setState(() {
      map = json.decode(response.body);
      data = map['postdata'];
      dataimages = data[0]['images'];
      Category = data[0]['categorys'];
      Episodes = data[0]['episodes'];
      Image = data[0]['images'][0]['url'];
      description = data[0]['description'];
      Titel = data[0]['Titel'];
      langue = data[0]['langue'];
      id = '${data[0]['id']}';
      type = data[0]['type'];
      rate = '${map['rate']}';
      countlikes = '${map['countlikes']}';
      countViews = '${map['countViews']}';
      commentcount = '${data[0]['comments_count']}';
      favoritstatut = map['favoritstatut'];
    });

    print('favoritstatuts :$favoritstatut');
    if (favoritstatut == 1) {
      favoritesColors = Colors.red;
    } else {
      favoritesColors = Colors.grey;
    }
    return description;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder(
        initialData: Container(
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        future: future,
        builder: (context, snapshot) {
          if (data == null) {
            return Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: MediaQuery.of(context).size.width,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(Image),
                                  onError: (exception, stackTrace) {},
                                  fit: BoxFit.cover)),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: <Color>[
                                    Colors.black,
                                    Colors.black.withOpacity(0.5),
                                    Colors.black.withOpacity(0.0)
                                  ],
                                  stops: [
                                    0.4,
                                    0.7,
                                    1
                                  ]),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: <Color>[
                                    Colors.black,
                                    Colors.black.withOpacity(0.5),
                                    Colors.black.withOpacity(0.0)
                                  ],
                                  stops: [
                                    0.01,
                                    0.7,
                                    1
                                  ]),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 20,
                          right: 20,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5.0),
                                      child: Text(
                                        '$Titel',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  ButtonBar(
                                    children: <Widget>[
                                      RaisedButton(
                                        color: Colors.transparent,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0, horizontal: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0)),
                                            color: Colors.red,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.play_circle_outline,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                Trailler,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              )
                                            ],
                                          ),
                                        ),
                                        onPressed: () {
                                          _launchURL(
                                              "https://www.youtube.com/results?search_query=" +
                                                  Titel +
                                                  Trailler);
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '${countViews}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.comment,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '$commentcount',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.stars,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '$rate',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    FlutterIcons.like1_ant,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '${countlikes}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0)),
                                      color: Colors.blue,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.language,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          '$langue',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0)),
                                      color: Colors.blue,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.live_tv,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          '$type',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: favoritesColors,
                        size: 30,
                      ),
                      onPressed: () {
                        favorit();
                        if (favoritstatut == 1) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(Delted_to_Your_Favorite_List),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(Added_to_Your_Favorite_List),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                    )
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                          height: MediaQuery.of(context).size.height,
                          child: DefaultTabController(
                              length: 3,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          color: Colors.black,
                                          child: TabBar(
                                            tabs: <Widget>[
                                              Tab(
                                                text: info,
                                              ),
                                              Tab(
                                                text: Galery,
                                              ),
                                              Tab(
                                                text: Episodes_variable,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      child: TabBarView(
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Expanded(
                                                child: showinfo(
                                                  Description: description,
                                                  Category: Category,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: showgalery(
                                                  data: dataimages,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: showepisode(
                                                  data: Episodes,
                                                  id: id,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )))
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
