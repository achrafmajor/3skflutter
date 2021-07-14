import 'package:flutter/material.dart';
import 'package:webstreaming/Network/Api.dart';
import 'package:webstreaming/rout/rout_const.dart';
import 'package:webstreaming/variable.dart';
import 'package:webstreaming/view/Login.dart';
import 'package:webstreaming/view/list.dart';
import 'package:webstreaming/view/main.dart';
import 'package:webstreaming/view/mylist.dart';
import 'package:webstreaming/view/player.dart';
import 'package:webstreaming/view/recentrelease.dart';
import 'package:webstreaming/view/schedule.dart';
import 'package:webstreaming/view/search.dart';
import 'package:webstreaming/view/show.dart';
import 'package:webstreaming/view/splashscreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Home:
      Map profile = settings.arguments;

      return MaterialPageRoute(builder: (context) => home(Profile: profile));
    case recent_const:
      return MaterialPageRoute(builder: (context) => recentreleas());
    case anime_const:
      return MaterialPageRoute(builder: (context) => list(Listname: Serie,Listapisub: ApimainUrl+'serielistsub'+UrlToken+homeState.Token,Listapidub:ApimainUrl+'serielistdub'+UrlToken+homeState.Token ,));
    case movie_const:
      return MaterialPageRoute(builder: (context) => list(Listname: movie,Listapisub: ApimainUrl+'movielistsub'+UrlToken+homeState.Token ,Listapidub:ApimainUrl+'movielistdub'+UrlToken+homeState.Token ,));

        case mylist_const:
      return MaterialPageRoute(builder: (context) => mylist());
    case Splashscreen_const:
      return MaterialPageRoute(builder: (context) => Splashscreen());
    case search_const:
      return MaterialPageRoute(builder: (context) => search());
    case schedule_const:
      return MaterialPageRoute(builder: (context) => schedule());
    case Login_const:
      return MaterialPageRoute(builder: (context) => Login());
    case player_const:
      var ID = settings.arguments;
      return MaterialPageRoute(builder: (context) => player(ID: ID,));
    case show_const:
      var ID = settings.arguments;
      return MaterialPageRoute(builder: (context) => show(id: ID,));
    default:
      return MaterialPageRoute(builder: (context) => home());
  }
}