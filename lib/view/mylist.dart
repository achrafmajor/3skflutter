
import 'package:flutter/material.dart';
import 'package:webstreaming/rout/rout_const.dart';
import 'package:webstreaming/variable.dart';
import 'package:webstreaming/view/main.dart';
import 'package:webstreaming/bloc/listgrid.dart';
import 'package:webstreaming/Network/Api.dart';

class mylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(My_list),
        backgroundColor: Colors.black,
      ),
      body:Container(
        color: Colors.black,
        child:  listgrid(url: ApimainUrl+"mylist"+UrlToken+homeState.Token,),
      ),
    );
  }
}
