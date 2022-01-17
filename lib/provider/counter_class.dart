import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/provider/counter_provider.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';
class Counter_Provider_Class extends StatefulWidget {
  const Counter_Provider_Class({Key? key}) : super(key: key);

  @override
  _Counter_Provider_ClassState createState() => _Counter_Provider_ClassState();
}

class _Counter_Provider_ClassState extends State<Counter_Provider_Class> {
  // int count =0;
  // void increment(){
  //   setState(() {
  //     count++;
  //   });
  // }
  // void decrement(){
  //   setState(() {
  //     count--;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
     final CounterProvider counterProvider = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: appBarDEcoration(context, 'Counter with Provider'),
      body: Center(
        child: Column(
          children: [
            Text(counterProvider.count.toString(),style: TextStyle(fontSize: 100),),
            TextButton(onPressed: counterProvider.increment, child: Text('Increment',style: TextStyle(
              fontSize: 50
            ),
            )),
            TextButton(onPressed: counterProvider.decrement, child: Text('Deccrement',style: TextStyle(fontSize: 50),
            ))
          ],
        ),
      ),

    );
  }
}
