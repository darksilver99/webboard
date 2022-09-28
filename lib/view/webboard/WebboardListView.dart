import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webboard/NoDataView.dart';
import 'package:webboard/model/WebboardList.dart';
import 'package:http/http.dart' as http;
import 'package:webboard/system/ColorTheme.dart';
import 'package:webboard/system/Info.dart';
import 'package:webboard/system/StringTheme.dart';

import 'WebboardSearchView.dart';
import 'adapter/WebboardAdapter.dart';

class WebboardListView extends StatefulWidget {
  const WebboardListView({Key? key}) : super(key: key);

  @override
  State<WebboardListView> createState() => _WebboardListViewState();
}

class _WebboardListViewState extends State<WebboardListView> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  int start = 0;
  List data = [];
  bool isMoreHasMoreData = true;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webboardList();
  }

  webboardList({keyword}) async {
    Map _map = {};
    _map.addAll({
      "start": start,
      "rows": 10,
      "keyword": keyword,
    });
    print(_map);
    var body = json.encode(_map);
    final response = await http.Client().post(Uri.parse(Info().webboardList), headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      var rs = json.decode(response.body);
      data.addAll(rs);
      setState(() {
        if (rs.toString() == '[]') {
          isMoreHasMoreData = false;
        }
        isLoading = false;
      });
    }
  }

  void onRefresh({keyword}) async {
    start = 0;
    data.clear();
    isMoreHasMoreData = true;
    isLoading = true;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 1000));
    webboardList(keyword: keyword);
    _refreshController.refreshCompleted();
  }

  void onLoading() async {
    start = start + 1;
    webboardList();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WebboardSearchView(
          onRefresh: onRefresh,
        ),
        Expanded(
          child: isLoading
              ? Center(
                  child: CupertinoActivityIndicator(),
                )
              : data.isEmpty
                  ? NoDataView(onRefresh: onRefresh)
                  : SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: isMoreHasMoreData,
                      header: ClassicHeader(),
                      controller: _refreshController,
                      onRefresh: onRefresh,
                      onLoading: onLoading,
                      footer: CustomFooter(
                        builder: (BuildContext context, LoadStatus? mode) {
                          return Container(
                            height: 55,
                            child: Center(child: CupertinoActivityIndicator()),
                          );
                        },
                      ),
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int i) {
                            return WebboardAdapter(
                              data: data[i],
                            );
                            //return Text(data[i]['subject']);
                          }),
                    ),
        ),
      ],
    );
  }
}
