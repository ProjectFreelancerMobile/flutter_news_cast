import 'dart:async';

import 'package:flutter/material.dart';

import '../../../res/style.dart';

enum DialogType { TWO_ACTION, THREE_ACTION }

class AppDialog {
  final BuildContext context;
  final DialogType type;
  final String title;
  final String description;
  final String okText;
  final VoidCallback? onOkPressed;
  final String cancelText;
  final VoidCallback? onCancelPressed;
  final String midText;
  final VoidCallback? onMidPressed;
  final bool dismissible;
  final VoidCallback? onDismissed;
  final TextStyle? cancelStyle;

  AppDialog({
    required this.context,
    this.type = DialogType.TWO_ACTION,
    this.title = '',
    this.description = '',
    this.okText = '',
    this.onOkPressed,
    this.cancelText = '',
    this.onCancelPressed,
    this.midText = '',
    this.onMidPressed,
    this.onDismissed,
    this.cancelStyle,
    this.dismissible = false,
  });

  void show() {
    showDialog(
        useRootNavigator: true,
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return _buildDialog;
        });
  }

  Widget get _buildDialog {
    return Scaffold(
      backgroundColor: color141414.withOpacity(0.6),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: GestureDetector(
          onTap: () {
            if (dismissible == true) {
              dismiss();
            }
          },
          child: Container(
            color: Colors.transparent,
            height: double.infinity,
            width: double.infinity,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        _buildTitleText,
                        SizedBox(height: 8),
                        _buildDescriptionText,
                        SizedBox(height: 16),
                        Divider(height: 1, thickness: 1, color: colorDivider),
                        _buildActions,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildTitleText {
    if ((title).isEmpty) return SizedBox();
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: text14.bold.textColor141414,
      ),
    );
  }

  Widget get _buildDescriptionText {
    if ((description).isEmpty) return SizedBox();
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: text12.textColor141414,
      ),
    );
  }

  Widget get _buildActions {
    if (type == DialogType.THREE_ACTION) {
      return Container(
        width: double.infinity,
        height: 160.hs,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildOkButton,
            Divider(height: 1, thickness: 1, color: colorDivider),
            _buildMidButton,
            Divider(height: 1, thickness: 1, color: colorDivider),
            _buildCancelButton,
          ],
        ),
      );
    } else {
      return Container(
        height: 56.hs,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildCancelButton,
            VerticalDivider(width: 1, thickness: 1, color: colorDivider),
            _buildOkButton,
          ],
        ),
      );
    }
  }

  Widget get _buildOkButton => TextButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(113.ws, 48.hs),
        ),
        onPressed: () {
          dismiss();
          onOkPressed?.call();
        },
        child: Text(
          okText,
          style: type == DialogType.THREE_ACTION ? text14.height16Per.textColorPrimary : text14.bold.height16Per.textColorF20606,
        ),
      );

  Widget get _buildMidButton => TextButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(113.ws, 48.hs),
        ),
        onPressed: () {
          dismiss();
          onOkPressed?.call();
        },
        child: Text(
          midText,
          style: text14.height16Per.textColorPrimary,
        ),
      );

  Widget get _buildCancelButton => TextButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(113.ws, 48.hs),
        ),
        onPressed: () {
          dismiss();
          onCancelPressed?.call();
        },
        child: Text(
          cancelText,
          style: cancelStyle ?? text14.bold.height16Per.textColorPrimary,
        ),
      );

  dismiss() {
    Navigator.of(context).pop();
    onDismissed?.call();
  }

  Future<bool> _onWillPop() async {
    return (dismissible);
  }
}
