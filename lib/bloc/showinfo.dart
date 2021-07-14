import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webstreaming/variable.dart';

class showinfo extends StatefulWidget {

    String Description;
   List Category;

  showinfo({Key key, this.Description, this.Category}) : super(key: key);

  @override
  showState createState() => showState(Description,Category);
}

class showState extends State<showinfo> {
  String Description_a;
  String Description;
   List Category;
  showState(this.Description, this.Category);
  void initState() {
    super.initState();
    this.setState(() {
      Description_a = Description;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(Category_variable,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
          ),
          Text(
            'Action,Adventure',
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
            softWrap: true,maxLines: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(Overview,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
          ),
          Expanded(
              child: Text('$Description',
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 16,
            ),
                overflow: TextOverflow.fade,
                softWrap: true,
          )),

        ],
      ),
    );
  }
}
