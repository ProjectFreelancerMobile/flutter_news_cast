import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

class CheckBoxWidget extends StatefulWidget {
  final Widget? checkedWidget;
  final Widget? unCheckedWidget;
  final bool? initValue;
  final Function(bool)? onCheckChange;

  CheckBoxWidget({this.checkedWidget, this.unCheckedWidget, this.initValue = false, this.onCheckChange});

  @override
  State<StatefulWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initValue ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: isChecked
          ? widget.checkedWidget ??
              Image.asset(
                DImages.checkedBlue,
                height: 20,
                width: 20,
              )
          : widget.unCheckedWidget ??
              Image.asset(
                DImages.uncheckBoxGray,
                height: 20,
                width: 20,
              ),
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          if (widget.onCheckChange != null) {
            widget.onCheckChange!(isChecked);
          }
        });
      },
    );
  }
}
