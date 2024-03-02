import 'dart:async';

import 'package:flutter/material.dart';

import '../../../res/style.dart';

enum DialogType { TEXT, INPUT }

class AppDialog {
  final BuildContext context;
  final DialogType type;
  final String title;
  final String description;
  final String okText;
  final VoidCallback? onOkPressed;
  final String cancelText;
  final VoidCallback? onCancelPressed;
  final bool dismissible;
  final Widget? input;
  final VoidCallback? onDismissed;

  AppDialog({
    required this.context,
    this.type = DialogType.TEXT,
    this.title = '',
    this.description = '',
    this.okText = '',
    this.onOkPressed,
    this.cancelText = '',
    this.onCancelPressed,
    this.onDismissed,
    this.input,
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
            child: Stack(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            child: Column(
                              children: [
                                _buildTitleText,
                                _buildDescriptionText,
                                if (type == DialogType.INPUT && input != null) ...[
                                  SizedBox(height: 10),
                                  input!,
                                ],
                                SizedBox(height: 10),
                                _buildActions,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
        style: text16.bold.textColor141414,
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
        style: text14.textColor141414,
      ),
    );
  }

  Widget get _buildActions {
    bool showOkButton = (okText).isNotEmpty;
    bool showCancelButton = (cancelText).isNotEmpty;
    List<Widget> buttons = [];
    if (showCancelButton) {
      buttons.add(_buildCancelButton);
    }
    if (showOkButton) {
      buttons.add(_buildOkButton);
    }
    return Container(
      // color: Colors.red,
      height: 48.hs,
      child: buttons.length == 2
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buttons,
            )
          : Center(child: buttons.first),
    );
  }

  Widget get _buildOkButton => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(113.ws, 48.hs),
          backgroundColor: colorPrimary,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        onPressed: () {
          dismiss();
          onOkPressed?.call();
        },
        child: Text(
          okText,
          style: text14.medium.height16Per.textColorWhite,
        ),
      );

  Widget get _buildCancelButton => OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(113.ws, 48.hs),
          side: BorderSide(color: colorPrimary, width: 1),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        onPressed: () {
          dismiss();
          onCancelPressed?.call();
        },
        child: Text(
          cancelText,
          style: text14.medium.height16Per.textColorPrimary,
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
