import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webstreaming/Network/Api.dart';
import 'package:webstreaming/Notification/Push_Notification.dart';
import 'package:webstreaming/bloc/menuProfile.dart';
import 'package:webstreaming/bloc/vertical_List.dart';
import 'package:webstreaming/rout/rout_const.dart';
import 'package:webstreaming/view/splashscreen.dart';
import 'package:webstreaming/widget/menu/menuitem.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:webstreaming/variable.dart';

@override
class home extends StatefulWidget {
  final Map Profile;
  const home({Key key, this.Profile}) : super(key: key);
  @override
  homeState createState() => new homeState(
        Profile,
      );
}

@override
class homeState extends State<home> {

  List dataanime, datamovie, dataveddets;
  String ProfileImage, ProfileName, provider;
  FacebookLogin facebookSignIn;
  final Map Profile;
  static String Token;
  homeState(this.Profile);
  @override
  void initState() {
    super.initState();
    ProfileName = Profile["name"];
    ProfileImage = Profile["picture"]["data"]["url"];
    provider = Profile["provider"];
    getToken();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Splashscreenstate.config != null) {
      if (Splashscreenstate.config['myads_statut'] == 1) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          showDialog(context: context, builder: (_) => ads_dialog(Splashscreenstate.config['myads_link'],Splashscreenstate.config['myads_image']));
        });
        print('ads dialog');
      }
    }
  }
  Future<String> getData() async {
    var response = await http.get(ApimainUrl+"main"+UrlToken+Token);
    dataanime = jsonDecode(response.body)['anime'];
    datamovie = jsonDecode(response.body)['movie'];
    dataveddets = jsonDecode(response.body)['veddets'];
    return 'true';
  }
  Future<String> getToken() async {
    var response = await http.post(ApimainUrl+"login" ,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, String>{
      'providerid': Profile["id"],
      'provider':Profile["provider"],
      'name':Profile["name"],
      'email':Profile["email"],
      'image':ProfileImage,
    } ));
    print(response.body);
     Map Tokenmap = new Map();
     Tokenmap = jsonDecode(response.body);
    setState(() {
     Token = Tokenmap["token"];
     print(Token);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(0),
              shape: Border(bottom: BorderSide(width: 2, color: Colors.white)),
              onPressed: () {  },
              child: Text(
                hom,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.pushNamed(context, recent_const);
              },
              child: Text(
                Recent_relaese,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, search_const);
              })
        ],
        backgroundColor: Colors.black,
      ),
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors
                .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
          ),
          child: SafeArea(
            child: Drawer(
              child: Container(
                color: Colors.black.withOpacity(0.75),
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    menuProfile(Image: ProfileImage, Name: ProfileName),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.white, width: 1)),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                          child: Text(
                        appname,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )),
                    ), // Titel
                    SizedBox(
                      height: 8,
                    ),
                    menuitem(
                      Titel: search_variable,
                      icon: Icons.search,
                      route: search_const,
                    ),
                    menuitem(
                      Titel: schedule_variable,
                      icon: Icons.history,
                      route: schedule_const,
                    ),
                    menuitem(Titel: news, icon: Icons.fiber_new),
                    menuitem(
                      Titel: Recent_relaese,
                      icon: Icons.watch_later,
                      route: recent_const,
                    ),
                    menuitem(
                      Titel: Anime_List,
                      icon: Icons.list,
                      route: anime_const,
                    ),
                    menuitem(
                      Titel: Movie_List,
                      icon: Icons.local_movies,
                      route: movie_const,
                    ),
                    menuitem(
                      Titel: My_list,
                      icon: Icons.playlist_add_check,
                      route: mylist_const,
                    ),
                    menuitem(Titel: History, icon: Icons.history),
                    menuitem(
                      Titel: Contact_Us,
                      icon: Icons.contacts,
                      route: "email",
                    ),
                    menuitem(
                      Titel: Share,
                      icon: Icons.share,
                      route: "sahre",
                    )
                  ],
                ),
              ),
            ),
          )),
      body: ListView(
        children: <Widget>[
          FutureBuilder(
              initialData: Center(
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              future: getData(),
              builder: (context, snapshot) {
                if (dataanime == null) {
                  return Container(

                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      CarouselSlider.builder(
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                          ),
                        itemCount: dataveddets.length,
                        itemBuilder: (BuildContext context, int itemIndex) =>
                            GestureDetector(
                              onTap: () {
                                String ID = "${dataveddets[itemIndex]["id"]}";
                                Navigator.pushNamed(context, show_const,arguments:ID );
                              },
                              child: Container(
                          child: Stack(
                              children: <Widget>[
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
                                            0.3,
                                            0.5,
                                            1
                                          ]),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Text(dataveddets[itemIndex]["Titel"],style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),   overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                          ),
                          decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(dataveddets[itemIndex]["images"][0]["url"])
                                ,fit: BoxFit.cover)
                          ),width: double.infinity,

                        ),
                            ),
                      ),
                      verticalList(
                        data: dataanime,
                        Titel: Serie,
                      ),
                      verticalList(
                        data: datamovie,
                        Titel: movie,
                      ),
                    ],
                  );
                }
              })
        ],
      ),
    );
  }
  Widget ads_dialog(String url, String Imagedialog) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    Imagedialog),
                fit: BoxFit.fill)),
        child: Stack(
          children: <Widget>[
            InkWell(
              child: Container(
                color: Colors.transparent,
              ),
              onTap: () {
                _launchURL(url);
              },
            ),
            Positioned(
              right: 2,
              top: 2,
              child: Material(
                // pause button (round)
                borderRadius: BorderRadius.circular(50), // change radius size
                color: Colors.grey[900].withOpacity(0.6), //button colour
                child: InkWell(
                  splashColor: Colors.grey[900].withOpacity(0.6),
                  // inkwell onPress colour
                  child: SizedBox(
                    width: 35, height: 35, //customisable size of 'button'
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  }, // or use onPressed: () {}
                ),
              ),
            )
          ],
        ),
      ),

      /*
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
*/
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
