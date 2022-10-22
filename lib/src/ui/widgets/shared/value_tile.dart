import 'package:flutter/material.dart';
import 'package:weathercourt/src/theme/colors.dart';


class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData? iconData;

  const ValueTile(this.label, this.value, {super.key, this.iconData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).cardColor,
          ),
        ),
        SizedBox(
          height: size.width * 0.02,
        ),
        iconData != null
            ? Icon(
                iconData,
                color: iconColor,
                size: 20,
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
