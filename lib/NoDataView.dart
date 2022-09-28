import 'package:flutter/material.dart';
import 'package:webboard/system/StringTheme.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({
    Key? key,
    this.onRefresh,
  }) : super(key: key);
  final onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(StringTheme().noData),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            onRefresh();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xFFB7B7B7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              "Refresh",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
