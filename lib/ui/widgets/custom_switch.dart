import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/colors.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({Key? key, required this.value, required this.onChanged, this.height = 64}) : super(key: key);

  final bool value;
  final void Function(bool value) onChanged;
  final double height;

  final _animationDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: SizedBox(
        width: height * 2,
        height: height,
        child: Stack(
          children: [
            AnimatedContainer(
              height: height - 6,
              margin: EdgeInsets.only(top: 4),
              alignment: Alignment.bottomCenter,
              duration: _animationDuration,
              decoration: BoxDecoration(
                color: value ? Colors.grey.withOpacity(0.4) : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(height),
              ),
            ),
            AnimatedPositioned(
              duration: _animationDuration,
              left: value ? height : 0,
              right: value ? 0 : height,
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(height),
                child: SizedBox(
                  height: height,
                  width: height,
                  child: Center(
                    child: AnimatedTheme(
                      duration: _animationDuration,
                      data: Theme.of(context).copyWith(
                        iconTheme: IconThemeData(
                          color: value ? Colors.yellow : Colors.grey,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: value ? colorPrimary : Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
