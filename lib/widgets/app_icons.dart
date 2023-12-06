import 'package:flutter/cupertino.dart';


class AppIcons extends StatelessWidget {
  final IconData icon;
  final Color backgroundcolor;
  final Color iconColor;
  final double Size;
  final double iconSize;
  const AppIcons({Key? key,
    required this.icon,
    this.backgroundcolor=const Color(0xfffcf4e4),
    this.iconColor=const Color(0xff756d54),
    this.Size=40,  this.iconSize=20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:Size,
      height: Size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: backgroundcolor,
      ),
       child: Icon(icon,color: iconColor,size: iconSize,),
    );
  }
}
