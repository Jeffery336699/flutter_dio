
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/test/headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenDioDemo extends StatefulWidget {
  @override
  _ScreenDioDemoState createState() => _ScreenDioDemoState();
}

class _ScreenDioDemoState extends State<ScreenDioDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DioHeaders(),
//      ProviderDemo(),
    );
  }
}


class DioHeaders extends StatefulWidget {
  @override
  _DioHeadersState createState() => _DioHeadersState();
}

class _DioHeadersState extends State<DioHeaders> {
  String data = "暂时没有数据";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1333);
    print("像素密度:${ScreenUtil.pixelRatio}");
    print("屏幕的宽:${ScreenUtil.screenWidth}");
    print("屏幕的高:${ScreenUtil.screenHeight}");

    ///通过这样设置美工给的高度333,是基于750的设计稿的
    Size(ScreenUtil().setWidth(750), ScreenUtil().setWidth(333));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "dio伪造请求头",
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28.0, allowFontScalingSelf: false)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: InkWell(
                onTap: _getdata,
                child: Text("获取数据"),
              ),
            ),
            Text("$data")
          ],
        ),
      ),
    );
  }

  void _getdata() async {
    print("开始获取数据了..................................");
    var data = await httpRequest();
    setState(() {
      this.data = data.toString();
    });
  }

  Future httpRequest() async {
    try {
      Response response;
      var dio = Dio();
      dio.options.headers = headersY;
      response = await dio
          .get("https://time.geekbang.org/serv/v2/explore/getBannerList");
      print("${response.data}");
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
