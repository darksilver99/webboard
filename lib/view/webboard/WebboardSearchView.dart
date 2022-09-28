import 'package:flutter/material.dart';
import 'package:webboard/system/ColorTheme.dart';

class WebboardSearchView extends StatefulWidget {
  const WebboardSearchView({
    Key? key,
    this.onRefresh,
  }) : super(key: key);

  final onRefresh;

  @override
  State<WebboardSearchView> createState() => _WebboardSearchViewState();
}

class _WebboardSearchViewState extends State<WebboardSearchView> {
  final _keyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: ColorTheme().subColor,
        borderRadius: BorderRadius.circular(4),
      ),
      height: 44,
      child: TextFormField(
        controller: _keyword,
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
          /*suffixIcon: IconButton(
            onPressed: () {
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),*/
          isDense: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        onFieldSubmitted: (text) {
          if (text.isNotEmpty) widget.onRefresh(keyword: text);
        },
      ),
    );
  }
}
