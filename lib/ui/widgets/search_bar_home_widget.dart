import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../../res/theme/theme_service.dart';

class SearchBarHomeWidget extends StatefulWidget {
  final String? hint;
  final Function(String)? onTextChanged;
  final bool autoFocus;
  final TextStyle? textStyle;
  final Widget? searchIcon;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;

  SearchBarHomeWidget({this.hint, this.onTextChanged, this.autoFocus = false, this.textStyle, this.searchIcon, this.controller, this.textInputAction, this.onFieldSubmitted});

  @override
  State<StatefulWidget> createState() => SearchBarHomeWidgetState();
}

class SearchBarHomeWidgetState extends State<SearchBarHomeWidget> {
  late TextEditingController _searchQuery;
  Timer? _debounce;

  _onSearchChanged() {
    setState(() {
      if (_debounce?.isActive == true) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        if (widget.onTextChanged != null) {
          widget.onTextChanged!(_searchQuery.text);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _searchQuery = widget.controller ?? TextEditingController();
    _searchQuery.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide.none,
    );
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(100),
      color: Colors.black12.withOpacity(0.2),
      child: TextFormField(
        onFieldSubmitted: widget.onFieldSubmitted,
        textInputAction: widget.textInputAction,
        autofocus: widget.autoFocus,
        controller: _searchQuery,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.ws, horizontal: 0.0),
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          errorBorder: border,
          disabledBorder: border,
          hintText: widget.hint ?? "",
          hintStyle: widget.textStyle?.copyWith(color: getColor().themeColorGrey),
          prefixIconConstraints: const BoxConstraints(maxHeight: 24, minHeight: 24),
          prefixIcon: Padding(padding: EdgeInsets.only(left: 10, right: 10), child: widget.searchIcon),
          suffixIconConstraints: const BoxConstraints(maxWidth: 30, maxHeight: 24, minHeight: 24),
          suffixIcon: _searchQuery.text != ""
              ? Padding(
                  padding: EdgeInsets.only(right: 10.ws),
                  child: MaterialButton(
                    height: 24.ws,
                    minWidth: 24.ws,
                    padding: EdgeInsets.all(0),
                    onPressed: () => _searchQuery.clear(),
                    child: Image.asset(
                      DImages.textClear,
                      width: 16.ws,
                      height: 16.ws,
                    ),
                    shape: CircleBorder(),
                  ),
                )
              : null,
          isDense: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
