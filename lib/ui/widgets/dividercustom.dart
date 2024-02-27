import 'package:flutter/material.dart';

import '../../res/style.dart';

class DividerCustom extends StatelessWidget {
  const DividerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: colorTextGreyLight, thickness: 0.3);
  }
}
