import 'package:bestcode2023/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';

class CodeBox extends StatelessWidget {
  const CodeBox({super.key, required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.2,
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(width: 1, color: Colors.black26),
      ),
      child: Center(
        child: SubtitleTextWidget(
          label: code,
          fontSize: 14,
        ),
      ),
    );
  }
}
