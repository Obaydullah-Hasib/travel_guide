import 'package:flutter/material.dart';
import 'package:travel_guide/pages/add_travel_spot.dart';
import 'package:travel_guide/pages/travel_spot.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';
import 'package:travel_guide/widgets/static_variables.dart';

class RegionPage extends StatefulWidget {
  int? index;
  String? region;

  @override
  _RegionPageState createState() => _RegionPageState();

  RegionPage({this.index, this.region});
}

class _RegionPageState extends State<RegionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDEcoration(context, '${widget.region}'),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTravelSpot()));

      },
      child: Icon(Icons.add_box_outlined),),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 100,
          ),
          itemCount: widget.index == 0
              ? StaticVariables.TravelBD.length
              : StaticVariables.TravelWorld.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){

                Navigator.push(context,MaterialPageRoute(builder: (context)=>TravelSpot(
                    spot:StaticVariables.TravelBD[index])) );
              },
              child: Card(
                  child: Center(
                    child: Text(
                widget.index == 0
                      ? StaticVariables.TravelBD[index]
                      : StaticVariables.TravelWorld[index],
              ),
                  )),
            );
          }),
    );
  }
}
