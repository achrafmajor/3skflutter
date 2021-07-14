import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webstreaming/rout/rout_const.dart';
import 'package:webstreaming/view/main.dart';
import 'package:webstreaming/view/splashscreen.dart';

class menuitem extends StatelessWidget {
  final String Titel;
  final IconData icon;
  final String route;
  const menuitem({Key key, this.Titel, this.icon, this.route}) : super(key: key);
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.only(top: 15, left: 10),
      child: InkWell(
          child: Row(children: <Widget>[
            Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              Titel,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ]),
          onTap:() => {
          if(route=="email"){
          _launchURL('mailto:${Splashscreenstate.config['email']}' )

      }else if(route=="sahre"){
          Share.share('Watch Anime Online on https://Gogoanime.click', subject: 'Gogoanime')
          }else{
              Navigator.pushNamed(context, route)
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
