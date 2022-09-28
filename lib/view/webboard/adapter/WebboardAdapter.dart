import 'package:flutter/material.dart';
import 'package:webboard/model/WebboardList.dart';
import 'package:webboard/system/ColorTheme.dart';

class WebboardAdapter extends StatelessWidget {
  const WebboardAdapter({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorTheme().primaryColor,
        borderRadius: BorderRadius.circular(4),
        /*border: Border.all(
          color: Color(0xFF33a1fd),
          width: 1,
        ),*/
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      height: 75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              data['subject'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Row(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    Text(
                      data['hits'],
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorTheme().textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  data['create_date'],
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorTheme().textColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
