import 'dart:ui';
import 'package:flutter/material.dart';


Size size=PlatformDispatcher.instance.views.first.physicalSize;



class All_Articals extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var width  =  MediaQuery.of(context).size.width;
    return Text('All Articals');
  }
}
