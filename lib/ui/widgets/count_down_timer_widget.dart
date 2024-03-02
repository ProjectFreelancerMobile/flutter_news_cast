import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';
import 'package:get/get.dart';

import '../../res/theme/text_theme.dart';
import '../../utils/date_time_utils.dart';

class CountDownTimerWidget extends StatefulWidget {
  final int start;
  final int end;
  final bool isOtp;
  final ValueNotifier? reload;
  final TextStyle? textStyle;
  final Function? endCountDown;
  final Function? onResend;

  CountDownTimerWidget({required this.start, this.isOtp = true, this.end = 0, this.reload, this.textStyle, this.endCountDown, this.onResend});

  @override
  State<StatefulWidget> createState() => _CountDownTimerWidgetState();
}

class _CountDownTimerWidgetState extends State<CountDownTimerWidget> {
  late Timer _timer;
  int _start = 0;
  bool isEnd = false;

  @override
  void initState() {
    super.initState();
    _start = widget.start;
    widget.reload?.addListener(() {
      startTimer();
    });
    startTimer();
  }

  void startTimer() {
    _start = widget.start;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (mounted)
          setState(
            () {
              if (_start == widget.end) {
                timer.cancel();
                setState(() {
                  isEnd = true;
                });
                if (widget.endCountDown != null) widget.endCountDown!();
              } else {
                _start = _start - 1;
              }
            },
          );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Text(
        widget.isOtp
            ? (isEnd
                ? textLocalization('otp.again')
                : textLocalization('otp.timer').trParams(
                    {
                      'field': formatTimeOfDuration(_start),
                    },
                  ))
            : formatTimeOfDuration(_start),
        style: widget.textStyle ?? (isEnd ? text14.textColorPrimary : text14.textColor141414),
      ),
      onPressed: () {
        if (widget.onResend != null) {
          widget.onResend!();
        }
        setState(() {
          isEnd = false;
        });
      },
    );
  }
}
