import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weathercourt/src/theme/colors.dart';
import 'package:weathercourt/src/ui/widgets/shared/glass_morphism.dart';

Widget logo(Size size) {
  return Text(
    'Weather Court',
    textAlign: TextAlign.center,
    style: GoogleFonts.fredokaOne(
      fontSize: size.width * 0.11,
      fontWeight: FontWeight.w900,
      color: Colors.white,
      shadows: [
        Shadow(
            blurRadius: 3,
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(0, 4))
      ],
    ),
  );
}

Widget backButton(BuildContext context) {
  return IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: const Icon(
      Icons.keyboard_arrow_left_outlined,
      color: white,
    ),
  );
}

Widget glassIconButton({
  required double radius,
  required String assetName,
  double? iconHeight,
  Widget? child, 
  double? width,
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      height: width,
      width: width,
      child: GlassMorphism(
        blur: 2,
        opacity: 0.3,
        radius: radius,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child??  SvgPicture.asset(
            assetName,
            height: iconHeight,
            color: white,
          ),
        ),
      ),
    ),
  );
}

errorToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.red,
  );
}
messageToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
  toastLength: Toast.LENGTH_LONG, 
  );
}

customDialog({
  required BuildContext context,
  Color color = white,
  Widget? title,
  double height = 150,
  List<Widget> children = const <Widget>[],
}) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return Dialog(
        backgroundColor: color,
        child: Container(
          height: height,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: title,
              ),
              ...children,
            ],
          ),
        ),
      );
    },
  );
}

loadingDialog({
  required BuildContext context,
  Widget? title,
  double height = 150,
}) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: height,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: title,
              ),
              circularProgress(60, 2),
            ],
          ),
        ),
      );
    },
  );
}

locationDeniedDialog({required BuildContext context, required String message}) {
  customDialog(
    color: white,
    context: context,
    height: 140,
    title: Text(
      message,
      style: const TextStyle(
        color: black,
      ),
    ),
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Ink(
            width: 80,
            height: 30,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Center(
                  child: Text(
                'Not now',
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Ink(
            width: 80,
            height: 30,
            child: InkWell(
              onTap: () async {
                Navigator.pop(context);

                await Geolocator.openLocationSettings();
              },
              child: const Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    ],
  );
}

confirmationDialog({
  required BuildContext context,
  required String message,
  required Function() onConfirm,
}) {
  customDialog(
    color: white,
    context: context,
    height: 140,
    title: Text(
      message,
      style: const TextStyle(
        color: black,
      ),
    ),
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Ink(
            width: 80,
            height: 30,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Center(
                  child: Text(
                'Cancel',
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Ink(
            width: 80,
            height: 30,
            child: InkWell(
              onTap: onConfirm,
              child: const Center(
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    ],
  );
}

Widget circularProgress(double size, double strokeWidth) {
  return SizedBox(
    height: size,
    width: size,
    child: CircularProgressIndicator(
      color: primary,
      strokeWidth: strokeWidth,
    ),
  );
}
