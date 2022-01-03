import 'package:flutter/material.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';
class MyHomePageClass extends StatefulWidget {
  const MyHomePageClass({Key? key}) : super(key: key);

  @override
  _MyHomePageClassState createState() => _MyHomePageClassState();
}

class _MyHomePageClassState extends State<MyHomePageClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarDEcoration(context, 'Home'),
      body: _bodyUi(),
    );
  }

  Widget _bodyUi(){
    Size size =MediaQuery.of(context).size;
    Color Primerycolor =Theme.of(context).primaryColor;
    Color Hintcolor = Theme.of(context).hintColor;
    return ListView(
      children: [
        Container(
          height: size.height*0.2,
          width: size.width,
          decoration: BoxDecoration(
            color: Primerycolor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.pin_drop_outlined,size: size.height*0.1,color: Colors.white,)
              ,Column(
                mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Travel Guide",style: TextStyle(color: Hintcolor,fontSize: size.height*0.04),),
                 Text("Travel Information for All Countries",style: TextStyle(color: Hintcolor,fontSize: size.height*0.02)),
               ],
              )
            ],
          ),
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ), itemCount: 6,itemBuilder: (context,index){
          return _gridBuilder(index);
        })
      ],
    );
  }
}

Widget _gridBuilder(int index) {
  return InkWell(

    onTap: (){},
    child: Card(
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
         index==0?Icons.my_location_sharp :
         index==1?Icons.circle :
         index==2?Icons.content_paste_sharp :
         index==3?Icons.stars_sharp :
         index==4?Icons.video_call_sharp :
         Icons.home,color: Colors.teal,size: 30,),
          Text(index==0?'Travel Bangladesh':
          index==1? 'World Tour' :
          index==2?'Travel Blog' :
          index==3?'Favourite' :
          index==4?'Video' :
          'Save Information',style: TextStyle(
            color: Colors.white,
          ),)
        ],
      ),
    ),
  );
}
