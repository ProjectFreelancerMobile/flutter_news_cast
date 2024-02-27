import 'package:flutter/cupertino.dart';
import 'package:flutter_news_cast/res/style.dart';

import 'image_shimmer.dart';
import 'rectangle_shimmer.dart';

class DiscoverItemShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 15.hs,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageShimmer(
              width: 40.ws,
              height: 40.ws,
              radius: 20.rs,
            ),
            SizedBox(
              width: 10.ws,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RectangleShimmer(width: 160.ws, height: 15.ws),
                SizedBox(
                  height: 3.hs,
                ),
                RectangleShimmer(width: 140.ws, height: 15.ws),
              ],
            )
          ],
        ),
        SizedBox(
          height: 15.hs,
        ),
        ImageShimmer(
          width: 345.ws,
          height: 200.ws,
          radius: 8.rs,
        ),
        SizedBox(
          height: 15.hs,
        ),
        RectangleShimmer(width: 250.ws, height: 30.ws),
        SizedBox(
          height: 15.hs,
        ),
        RectangleShimmer(width: 345.ws, height: 15.ws),
        SizedBox(
          height: 5.hs,
        ),
        RectangleShimmer(width: 345.ws, height: 15.ws),
        SizedBox(
          height: 5.hs,
        ),
        RectangleShimmer(width: 345.ws, height: 15.ws),
        SizedBox(
          height: 15.hs,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RectangleShimmer(width: 150.ws, height: 20.ws),
            SizedBox(
              width: 20.hs,
            ),
            RectangleShimmer(width: 150.ws, height: 20.ws),
          ],
        ),
        SizedBox(
          height: 15.hs,
        )
      ],
    );
  }
}
