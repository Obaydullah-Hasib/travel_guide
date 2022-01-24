import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/pages/add_travel_spot.dart';
import 'package:travel_guide/pages/crud.dart';
import 'package:travel_guide/pages/crudBySayedVai.dart';
import 'package:travel_guide/pages/imagePicker.dart';
import 'package:travel_guide/pages/myhomepage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:travel_guide/provider/counter_class.dart';
import 'package:travel_guide/provider/counter_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CounterProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => TestProvider(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => AuthProvider(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => TravelProvider(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travel Guide',
        theme: ThemeData(
          primaryColor: Colors.teal,
          primarySwatch: Colors.teal,
          hintColor: Colors.white,
        ),
        home: const AddTravelSpot(),
      ),
    );
  }
}
