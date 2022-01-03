import 'package:flutter/material.dart';
PreferredSizeWidget appBarDEcoration(BuildContext context, String appBarTitle){
  return  AppBar(
    title: Text(appBarTitle),
    centerTitle: true,
    backgroundColor: Theme.of(context).primaryColor,
  );
}