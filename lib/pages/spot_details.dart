import 'package:flutter/material.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';
class Spot_Details extends StatefulWidget {
  String? spotname;
  String? description;
  String? image;
  Spot_Details({this.spotname, this.description, this.image});
  @override
  _Spot_DetailsState createState() => _Spot_DetailsState();
}

class _Spot_DetailsState extends State<Spot_Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDEcoration(context, '${widget.spotname}'),
      body: Column(

        children: [
          ClipRRect(
             child: Image.asset('${widget.image}'),
          ),
          Text('${widget.spotname}'),
          Text('${widget.description}'),

        ],
      ),
    );
  }
}
