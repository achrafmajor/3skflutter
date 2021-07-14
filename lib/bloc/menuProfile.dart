import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webstreaming/bloc/vertical_List.dart';
import 'package:webstreaming/rout/rout_const.dart';
import 'package:webstreaming/variable.dart';
import 'package:webstreaming/view/Login.dart';

class menuProfile extends StatefulWidget {
  final String Image,Name;

  const menuProfile({Key key, this.Image, this.Name,}) : super(key: key);
  @override
  menuProfilestate createState() => new menuProfilestate(Image: Image,Name: Name);
}

class menuProfilestate extends State<menuProfile> {
   final String Image,Name;
   GoogleSignInAuthentication auth;
   GoogleSignIn googleSignIn;

   menuProfilestate({Key key, this.Image, this.Name}) ;
   Future<Null> _logOut() async {

    if(FacebookLoginStatus.loggedIn != null) {
      print('facebook log out');


      Loginstate.facebookSignIn.logOut();
    }else{
      print('google log out');
      Loginstate.googleSignIn.signOut();
    }
    Navigator.of(context).pushNamedAndRemoveUntil(Login_const, (Route<dynamic> route) =>false);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
                Image),
            backgroundColor: Colors.transparent,),
       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Text(Name,
               style: TextStyle(
                   color: Colors.white,
                   fontSize: 18,
                   fontWeight: FontWeight.w500)),

           FlatButton(onPressed: () {
             _logOut();
           }, child: Container(
             padding: EdgeInsets.all(5.0),
             decoration: BoxDecoration(
                 color: Colors.blue,
                 borderRadius: BorderRadius.all(Radius.circular(10.0))
             ),child: Text(
             Sign_Out,
             style: TextStyle(
               color: Colors.white,
               fontSize: 14,
               fontWeight: FontWeight.w500,
             ),
           ),

           )
           )
         ],
       )
        ],
      ),
    );
  }



}
