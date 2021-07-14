import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webstreaming/Network/Api.dart';
import 'package:webstreaming/variable.dart';
import 'package:webstreaming/widget/lastepisode.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';
import 'package:webstreaming/view/main.dart';

class player extends StatefulWidget {
  final String ID;

  const player({Key key, this.ID}) : super(key: key);

  @override
  playerstate createState() => new playerstate(ID);
}

class playerstate extends State<player> {
  final String id;
  Future datafuture;
  WebViewController controller;
  String url;
  List data;
  Map map;
  bool _isloading = true;
  bool _listvisibility = false;

  playerstate(this.id);

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
  @override

  void initState() {
    super.initState();
   getData(id);
  }

  Future<Null> getData(String id) async {
    var response =
        await http.get(ApimainUrl+"show/player/$id"+UrlToken+homeState.Token);
    setState(() {
      map = json.decode(response.body);
      data = map['episodedata'][0]['videos'];
      url = mainUrl+'video/${data[0]["id"]}';
    });

    controller.loadUrl(url);
    return url;
  }

  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      body: FutureBuilder(
        initialData: Visibility(
          visible: _isloading,
          child: Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
        future:datafuture,
        builder: (context, snapshot) {
          if (data != null) {
            return Stack(
              children: <Widget>[

                WebView(
                  initialUrl: url,
                  onPageStarted: (url) {
                    _isloading = true;
                  },
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    controller = webViewController;
                  },
                  navigationDelegate: (NavigationRequest request) {

                    print('Bloking navigation to $request');
                    return NavigationDecision.prevent;
                  },
                  onPageFinished: (String url) {
                    setState(() {
                      _isloading = false;
                    });
                  },
                ),
                Visibility(
                  visible: _isloading,
                  child: Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_listvisibility == false) {
                            _listvisibility = true;
                          } else {
                            _listvisibility = false;
                          }
                        });
                      },
                    ),
                    Visibility(
                      visible: _listvisibility,
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print(
                                    mainUrl+'video/${data[index]["id"]}');
                                setState(() {
                                  _isloading = true;
                                  _listvisibility = false;
                                  url =
                                      mainUrl+'video/${data[index]["id"]}';
                                  controller.loadUrl(
                                      mainUrl+'video/${data[index]["id"]}');
                                });
                              },
                              child: Container(
                                width: 100,
                                padding: EdgeInsets.all(5.0),
                                margin: EdgeInsets.all(5.0),
                                child: Text(
                                  server+' ${index + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        width: 3, color: Colors.white)),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          } else {
            return Visibility(
              visible: _isloading,
              child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          }
        },
      ),
    );
  }
}
