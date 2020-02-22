import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/test/headers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DioHeaders(),
    );
  }
}

class DioHeaders extends StatefulWidget {
  @override
  _DioHeadersState createState() => _DioHeadersState();
}

class _DioHeadersState extends State<DioHeaders> {
  String data="暂时没有数据";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dio伪造请求头"),
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

  void _getdata() async{
    print("开始获取数据了..................................");
   var data= await httpRequest();
   setState(() {
     this.data=data.toString();
   });
  }

  Future httpRequest() async{
    try{
      Response response;
      var dio = Dio();
      dio.options.headers=headersY;
      response=await dio.get("https://time.geekbang.org/serv/v2/explore/getBannerList");
      print("${response.data}");
      return response.data;
    }catch(e){
      return print(e);
    }
  }
}
