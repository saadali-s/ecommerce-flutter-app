import 'package:flutter/material.dart';
import 'package:project/widgets/text_widget.dart';
import 'package:project/widgets/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return FittedBox(
        child: Row(
      children: [
        TextWidget(
          text: 'R222',
          color: Colors.green,
          textSize: 22,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          'R1233',
          style: TextStyle(
            fontSize: 15,
            color: color,
            decoration: TextDecoration.lineThrough,
          ),
        )
      ],
    ));
  }
}
