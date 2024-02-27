import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../res/style.dart';
import '../../../res/theme/theme_service.dart';

class DTextFromField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? onValidated; // handle error here
  final Function(String?)? onSaved;
  final Function(String?)? onChange;
  final Function()? onComplete;
  final TextStyle? textStyle;
  final TextStyle? textHintStyle;
  final TextStyle? textLabelHintStyle;
  final TextStyle? errorStyle;
  final TextStyle? rightTitleStyle;
  final String? hintText;
  final Color? strokeColor;
  final Widget? prefixIcon;
  final double? prefixPadding;
  final Widget? suffixIcon;
  final Widget? rightIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool? alignLabelWithHint;
  final String? leftTitle;
  final String? rightTitle;
  final String? errorText;
  final BoxConstraints? prefixConstraints;
  final bool autoFocus;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(PointerDownEvent)? onTapOutside;
  final bool? isHideCounterText;
  final bool? textCenter;
  final bool isUnderBorder;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final FocusNode? focusNode;

  DTextFromField({
    this.controller,
    this.errorStyle,
    this.onValidated,
    this.onSaved,
    this.onChange,
    this.onComplete,
    this.hintText,
    this.textStyle,
    this.textHintStyle,
    this.textLabelHintStyle,
    this.rightTitleStyle,
    this.strokeColor,
    this.obscureText,
    this.prefixIcon,
    this.rightIcon,
    this.keyboardType,
    this.suffixIcon,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.alignLabelWithHint = false,
    this.leftTitle,
    this.rightTitle,
    this.errorText,
    this.autoFocus = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.prefixPadding,
    this.isHideCounterText,
    this.textCenter,
    this.floatingLabelBehavior,
    this.focusNode,
    this.isUnderBorder = true,
    this.prefixConstraints = const BoxConstraints(minWidth: 26, maxWidth: 26, maxHeight: 26, minHeight: 26),
    this.contentPadding,
  });

  InputBorder _inputBorder(Color? strokeColor, BuildContext context) {
    return isUnderBorder
        ? UnderlineInputBorder(borderSide: BorderSide(color: strokeColor ?? getColor().textColorTextGrey, width: 0.3))
        : OutlineInputBorder(borderSide: BorderSide(color: strokeColor ?? getColor().textColorTextGrey, width: 1), borderRadius: const BorderRadius.all(Radius.circular(8.0)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          focusNode: focusNode,
          maxLength: maxLength,
          enabled: enabled,
          autofocus: autoFocus,
          obscureText: obscureText ?? false,
          maxLines: maxLines,
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          validator: onValidated,
          onSaved: onSaved,
          onChanged: onChange,
          onEditingComplete: onComplete,
          textAlign: textCenter == true ? TextAlign.center : TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          style: textStyle ?? text18.textColorTextGrey,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          onTapOutside: onTapOutside,
          decoration: InputDecoration(
            alignLabelWithHint: alignLabelWithHint,
            label: Text(alignLabelWithHint == true ? hintText ?? "" : '', style: textLabelHintStyle),
            counterText: isHideCounterText == true ? "" : null,
            errorText: errorText,
            counterStyle: text12.textColorTextGrey,
            hintText: hintText ?? "",
            hintStyle: textHintStyle ?? textStyle?.copyWith(color: getColor().textColorTextGreyLight) ?? text18.textColorTextGrey,
            prefixIconConstraints: prefixConstraints,
            prefixIcon: prefixIcon != null
                ? Padding(
                    child: prefixIcon,
                    padding: EdgeInsets.only(left: prefixPadding != null ? prefixPadding! : 0, right: prefixPadding != null ? prefixPadding! : 16.ws, top: 14),
                  )
                : null,
            isDense: true,
            errorStyle: errorStyle ?? text12.textErrorColor,
            contentPadding: contentPadding ?? EdgeInsets.only(top: 6.ws, bottom: 18.ws),
            enabledBorder: _inputBorder(strokeColor, context),
            focusedBorder: _inputBorder(strokeColor, context),
            border: _inputBorder(strokeColor, context),
            disabledBorder: _inputBorder(strokeColor, context),
            focusedErrorBorder: _inputBorder(getColor().error, context),
            errorBorder: _inputBorder(getColor().error, context),
            floatingLabelBehavior: floatingLabelBehavior ?? FloatingLabelBehavior.always,
          ),
        ),
        if (leftTitle != null) ...[
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              leftTitle ?? "",
              style: text16.bold.textColorPrimary,
            ),
          ),
        ],
        if (rightTitle != null) ...[
          Positioned(
            bottom: 4,
            right: 0,
            child: Text(
              rightTitle ?? "",
              style: rightTitleStyle ?? text16.bold.textColorBlack,
            ),
          ),
        ],
        if (rightIcon != null) ...[
          Positioned(
            bottom: 14.ws,
            right: 34.ws,
            child: SizedBox(
              width: 18.ws,
              height: 18.ws,
              child: rightIcon!,
            ),
          ),
        ],
        if (suffixIcon != null) ...[
          Positioned(
            bottom: prefixPadding ?? 16.ws,
            right: 0,
            child: SizedBox(
              width: 26.ws,
              height: 26.ws,
              child: suffixIcon!,
            ),
          ),
        ],
      ],
    );
  }
}

class ClearTextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final String? leftTitle;
  final String? rightTitle;
  final Widget? prefixIcon;
  final String? hint;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final Color? underlineColor;
  final bool? obscureText;
  final int? maxLength;
  final String? Function(String?)? onValidated;
  final String? errorText;
  final TextStyle? errorStyle;
  final bool? isClear;
  final EdgeInsetsGeometry? contentPadding;

  ClearTextField(
      {this.hint,
      this.inputFormatters,
      this.maxLength,
      this.controller,
      this.prefixIcon,
      this.leftTitle,
      this.rightTitle,
      this.textStyle,
      this.keyboardType,
      this.underlineColor,
      this.onValidated,
      this.obscureText,
      this.errorText,
      this.isClear = true,
      this.contentPadding = const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
      this.errorStyle});

  @override
  State<StatefulWidget> createState() => _ClearTextFieldState();
}

class _ClearTextFieldState extends State<ClearTextField> {
  TextEditingController? controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return DTextFromField(
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      textStyle: widget.textStyle,
      strokeColor: widget.underlineColor ?? getColor().themeColorGrey,
      controller: controller,
      hintText: widget.hint,
      maxLength: widget.maxLength,
      obscureText: widget.obscureText,
      prefixIcon: widget.prefixIcon,
      leftTitle: widget.leftTitle,
      rightTitle: widget.rightTitle,
      onValidated: widget.onValidated,
      errorText: widget.errorText,
      errorStyle: widget.errorStyle,
      contentPadding: widget.contentPadding,
      suffixIcon: MaterialButton(
        height: 24,
        minWidth: 24,
        padding: EdgeInsets.all(0),
        onPressed: () => controller?.clear(),
        child: Icon(widget.isClear == true ? Icons.close : Icons.remove_red_eye, size: 25.ws),
        shape: CircleBorder(),
      ),
    );
  }
}

class CountryCodeTextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final String? leftTitle;
  final String? rightTitle;
  final Widget? prefixIcon;
  final String? hint;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final Color? underlineColor;
  final int? maxLength;
  final String? Function(String?)? onValidated;
  final String? errorText;
  final TextStyle? errorStyle;
  final EdgeInsetsGeometry? contentPadding;

  CountryCodeTextField(
      {this.hint,
      this.inputFormatters,
      this.maxLength,
      this.controller,
      this.prefixIcon,
      this.leftTitle,
      this.rightTitle,
      this.textStyle,
      this.keyboardType,
      this.underlineColor,
      this.onValidated,
      this.errorText,
      this.contentPadding,
      this.errorStyle});

  @override
  State<StatefulWidget> createState() => _CountryCodeTextFieldState();
}

class _CountryCodeTextFieldState extends State<CountryCodeTextField> {
  TextEditingController? controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    controller?.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DTextFromField(
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      textStyle: widget.textStyle,
      strokeColor: widget.underlineColor ?? getColor().themeColorGrey,
      controller: controller,
      hintText: widget.hint,
      maxLength: widget.maxLength,
      prefixIcon: widget.prefixIcon,
      leftTitle: widget.leftTitle,
      enabled: false,
      rightTitle: widget.rightTitle,
      onValidated: widget.onValidated,
      errorText: widget.errorText,
      errorStyle: widget.errorStyle,
      contentPadding: widget.contentPadding,
      textCenter: true,
      isHideCounterText: true,
      suffixIcon: MaterialButton(
        height: 30,
        minWidth: 24,
        padding: EdgeInsets.only(right: 3),
        onPressed: () => {},
        child: Text(
          "|",
          style: text18.textColorBlack,
        ),
        shape: CircleBorder(),
      ),
    );
  }
}

class LowerCaseTxt extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toLowerCase());
  }
}
