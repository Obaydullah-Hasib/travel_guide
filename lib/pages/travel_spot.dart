import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:travel_guide/model/travel_data.dart';
import 'package:travel_guide/model/travel_model.dart';
import 'package:travel_guide/pages/spot_details.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';
class TravelSpot extends StatefulWidget {
  String? spot;

  @override
  _TravelSpotState createState() => _TravelSpotState();

  TravelSpot({this.spot});
}

class _TravelSpotState extends State<TravelSpot> {
  List <TravelModel> travelList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    travelList=GetTravel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDEcoration(context, '${widget.spot}\'s Travel Details'),
      body: _bodyUI(),
    );
  }
  Widget _bodyUI(){
    return GridView.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,
            mainAxisExtent: 350
        ),
        itemCount: 6,
        itemBuilder: (context,index){
      return InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Spot_Details(spotname:travelList[index].spotname,
               description:travelList[index].travelregion,
               image:travelList[index].image)));
        },
        child: Container(
          margin: EdgeInsets.only(
            bottom: 16,left: 10,right: 10
          ),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.deepOrangeAccent.withOpacity(0.1),
                blurRadius: 5.0,
                spreadRadius: 3.0,
                offset: Offset(0,3)
              )
            ]
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15)
                ),
                child: Image.asset('${travelList[index].travelregion}',
                height: 200,
                width: double.maxFinite,
                fit: BoxFit.cover,),

              ),
              SizedBox(
                height: 10,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),

                child: Column(
                  children: [
                    Text('${travelList[index].spotname}'),
                   // Text('${widget.spot}'),
                   Text('${travelList[index].travelregion}')
                   // Text('lorem(paragraphs: 1, words: 50 ) ad fadfkj asef lkj;asejf k kj;fdl jasef ;lkfdmgaesr g;lkdfmvaa dsfhbasdf,hsdfbaliufhjalsdkfjha fuakhf  lasdijfk adsfj;aoisfjama;dlsifj alm a;sdijfa lsdkf;dlafigj a;ifkg ms;dflikgja s;gf lj;go alsd;kfj ;alsdkf ala;siel jfr',maxLines: 2,textAlign: TextAlign.justify,)
                  ],
                ) ,
              )
            ],
          ),
      ),
      ) ;
    });
  }
}
