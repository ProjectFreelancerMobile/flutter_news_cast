import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../res/style.dart';

Widget buildRowImageTextIcon(SvgPicture svgPicture, String label, {TextStyle? textStyle, Widget? widgetExpand}) {
  return SizedBox(
    height: 55.ws,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(width: 22.ws, height: 22.ws, child: svgPicture),
        SizedBox(width: 16.ws),
        Expanded(
          child: Text(
            label,
            style: textStyle ?? text14.textColorBlack,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widgetExpand != null) widgetExpand
      ],
    ),
  );
}

// Widget buildRowTextImageIcon(SvgPicture svgPicture, String label, {TextStyle? textStyle, MainAxisAlignment? mainAxisAlignment, VoidCallback? onPress, bool? isExpanded}) {
//   return Row(
//     mainAxisSize: mainAxisAlignment != null ? MainAxisSize.max : MainAxisSize.min,
//     mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
//     children: <Widget>[
//       isExpanded == true
//           ? Expanded(
//               child: Text(
//                 label,
//                 style: textStyle ?? text16.textColorWhite,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             )
//           : Text(label, style: textStyle ?? text16.textColorWhite),
//       const Padding(padding: EdgeInsets.all(5)),
//       onPress != null ? TouchableOpacity(onPressed: onPress, child: svgPicture) : svgPicture,
//     ],
//   );
// }
//
// Widget buildColumnImageTextIcon(SvgPicture svgPicture, String label, {TextStyle? textStyle}) {
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     children: <Widget>[
//       svgPicture,
//       const Padding(padding: EdgeInsets.all(5)),
//       Text(
//         label,
//         style: textStyle ?? text16.textColorWhite,
//         overflow: TextOverflow.ellipsis,
//       ),
//     ],
//   );
// }
//
// Widget buildColumnTextImageIcon(SvgPicture svgPicture, String label, {TextStyle? textStyle}) {
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     children: <Widget>[
//       Text(
//         label,
//         style: textStyle ?? text16.textColorWhite,
//         overflow: TextOverflow.ellipsis,
//       ),
//       const Padding(padding: EdgeInsets.all(5)),
//       svgPicture,
//     ],
//   );
// }

Widget buildColumnTextImagePayment(Widget svgPicture, String label, {TextStyle? textStyle}) {
  return SizedBox(
    width: 90.ws,
    height: 90.ws,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(width: 27.ws, height: 27.ws, child: svgPicture),
        SizedBox(height: 2.ws),
        Text(
          label,
          style: textStyle ?? text16.semiBold.textColorWhite,
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
      ],
    ),
  );
}

Widget buildColumnTextImageMain(Widget svgPicture, String label, {TextStyle? textStyle, double? size}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(width: size ?? 40.ws, height: size ?? 40.ws, child: svgPicture),
      SizedBox(height: 6.ws),
      Text(
        label,
        style: textStyle ?? text13.semiBold.textColorPrimary,
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    ],
  );
}

Widget buildColumnTextImageMenu(Widget svgPicture, String label, {TextStyle? textStyle, double? size, int? maxline = 2}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(width: size ?? 40.ws, height: size ?? 40.ws, child: svgPicture),
      SizedBox(height: 6.ws),
      Text(
        label,
        style: textStyle ?? text13.semiBold.textColorPrimary,
        textAlign: TextAlign.center,
        maxLines: maxline,
      ),
    ],
  );
}

Widget buildColumnTextImageMenuNotification(Image svgPicture, String label, {TextStyle? textStyle, bool isNew = false}) {
  return Expanded(
    child: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 40.ws, height: 40.ws, child: svgPicture),
            SizedBox(height: 6.ws),
            SizedBox(
              width: double.infinity,
              height: 60.ws,
              child: Text(
                label,
                style: textStyle ?? text15.semiBold.textColorBlack,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
            ),
          ],
        ),
        if (isNew) ...[
          Positioned(
            right: 18.ws,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.ws)),
                color: Colors.red,
              ),
              padding: EdgeInsets.symmetric(horizontal: 6.ws),
              child: Text(
                'Mới',
                style: text11.textColorWhite,
              ),
            ),
          ),
        ]
      ],
    ),
  );
}
