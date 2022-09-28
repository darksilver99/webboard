import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webboard/model/WebboardList.dart';
import 'package:http/http.dart' as http;
import 'package:webboard/system/Info.dart';

import '../adapter/WebboardAdapter.dart';

class WebboardListViewOld extends StatefulWidget {
  const WebboardListViewOld({Key? key}) : super(key: key);

  @override
  State<WebboardListViewOld> createState() => _WebboardListViewOldState();
}

class _WebboardListViewOldState extends State<WebboardListViewOld> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  int start = 0;

  void _onRefresh() async {
    // monitor network fetch
    setState(() {
      start = 0;
    });
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length + 1).toString());
    start = start + 1;
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  Future<List<WebboardList>> webboardList(start) async {
    Map _map = {};
    _map.addAll({
      "start": start,
      "rows": 10,
    });
    print(_map);
    var body = json.encode(_map);
    final response = await http.Client().post(Uri.parse(Info().webboardList), headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new WebboardList.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occureaaad!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: webboardList(start),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<WebboardList> data = snapshot.data;
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  //return WebboardAdapter(data: data[index]);
                  return Container();
                }),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
