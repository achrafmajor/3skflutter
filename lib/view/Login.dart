import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webstreaming/rout/rout_const.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:webstreaming/variable.dart';
import 'package:webstreaming/view/splashscreen.dart';

class Login extends StatefulWidget {
  @override
  Loginstate createState() => new Loginstate();
}

class Loginstate extends State<Login> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  Map profile;
   bool _cheking=true;
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  @override
  void initState() {
    _facebookislogin();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount acc) {
      setState(() {
        var profile = {
          "name": acc.displayName,
          "picture": {
            "data": {"url": acc.photoUrl}
          },
          "email": acc.email,
          "id": acc.id,
          "provider": 'google'
        };
        print(profile);
        Navigator.of(context).pushNamedAndRemoveUntil(
            Home, (Route<dynamic> route) => false,
            arguments: profile);
      });
    });
    googleSignIn.signInSilently();
   setState(() {
     _cheking=false;
   });
    super.initState();
  }

  Future<Null> _facebookislogin() async {
    if (await facebookSignIn.isLoggedIn) {
      print('ok');
      _login();
    }
  }
  Future<Null> _login() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
       /* print('''*
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');*/
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        profile = json.decode(graphResponse.body);
        profile['provider'] = 'Facebook';
        print(profile);
        Navigator.of(context).pushNamedAndRemoveUntil(
            Home, (Route<dynamic> route) => false,
            arguments: profile);
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          _cheking=false;
        });
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        setState(() {
          _cheking=false;
        });
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            Splashscreenstate.config['Loginimage'] ),
                        fit: BoxFit.cover),
                  ),
                ),
                Center(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[

                              TextSpan(
                                  text: 'قصة عشق',

                                  style: GoogleFonts.reemKufi(
                                      textStyle:   TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,

                                      ),
                                  )),

                            ],
                          ),
                        ),
                        SignInButton(
                          Buttons.Facebook,
                          text: Sign_in_with_f,
                          onPressed: () {
                            setState(() {
                              _cheking=true;
                            });
                            _login();

                          },
                        ),
                        SignInButton(
                          Buttons.Google,
                          text: Sign_in_with_g,
                          onPressed: () {
                            setState(() {
                              _cheking=true;
                            });
                            _handleSignIn();
                          },
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text:Note,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  )),
                            ],
                          ),
                        ),
                        ButtonTheme(
                          buttonColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          //adds padding inside the button
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          //limits the touch area to the button area
                          minWidth: 0,
                          //wraps child's width
                          height: 0,
                          //wraps child's height
                          child: RaisedButton(
                              onPressed: () {
                                _launchURL(
                                    'mailto:${Splashscreenstate.config['email']}');
                              },
                              child: Text(Contact_Us,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 10,
                                  ))), //your original button
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: _cheking,
            child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.8),
              child: Center(child: CircularProgressIndicator(),),
        ))
      ],
    );
  }

  /////Google //////
  Future<void> _handleSignIn() async {
    try {
      await googleSignIn.signIn().then((GoogleSignInAccount acc) async {
        GoogleSignInAuthentication auth = await acc.authentication;
        print(acc.id);
        print(acc.email);
        print(acc.displayName);
        print(acc.photoUrl);
        setState(() {
          var profile = {
            "name": acc.displayName,
            "picture": {
              "data": {"url": acc.photoUrl}
            },
            "email": acc.email,
            "id": acc.id,
            "provider": 'google'
          };
          print(profile);
          setState(() {
            _cheking=false;
          });
          Navigator.of(context).pushNamedAndRemoveUntil(
              Home, (Route<dynamic> route) => false,
              arguments: profile);
        });
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => googleSignIn.disconnect();

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
