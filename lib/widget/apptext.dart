import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class Apptext extends StatelessWidget{

  String? data;
  double? size;
  Color? color;
  FontWeight? fw;
  TextAlign? align;

  Apptext({super.key,required this.data,this.size,this.color,this.fw,this.align});

  @override
  Widget build(BuildContext context) {
    return Text(data.toString(),textAlign: align,style: TextStyle(fontSize: size,color: color,fontWeight: fw),);
  }
}