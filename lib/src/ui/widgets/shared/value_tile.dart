import 'package:flutter/material.dart';
import 'package:weathercourt/src/theme/colors.dart';


class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData? iconData;
  final Color? textColor;

  const ValueTile(this.label, this.value, {super.key, this.iconData, this.textColor});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: textColor?? white,
          ),
        ),
        SizedBox(
          height: size.width * 0.02,
        ),
        iconData != null
            ? Icon(
                iconData,
                color: iconColor,
                size: size.width * 0.10,
              )
            : const SizedBox.shrink(),
         SizedBox(
          height: size.width * 0.04,
        ),
        Text(
          value,
          style:  TextStyle(color: textColor?? Colors.white),
        ),
      ],
    );
  }
}
