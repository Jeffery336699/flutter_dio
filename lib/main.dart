import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/provider/counter.dart';
import 'package:flutter_dio/test/headers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

//void main() => runApp(MyApp());

void main() {
  final providers = Providers()..provide(Provider.function((context) => Counter(0)));

  runApp(ProviderNode(providers: providers,child: CounterApp(),));
}

/// CounterApp which obtains a counter from the widget tree and uses it.
class CounterApp extends StatelessWidget {
  // The widgets here get the value of Counter in three different
  // ways.
  //
  // - Provide<Counter> creates a widget that rebuilds on change
  // - Provide.value<Counter> obtains the value directly
  // - Provide.stream<Counter> returns a stream
  @override
  Widget build(BuildContext context) {
    // Gets the Counter from the nearest ProviderNode that contains a Counter.
    // This does not cause this widget to rebuild when the counter changes.
    final currentCounter = Provide.value<Counter>(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Provider"),
        ),
        body: Column(children: [
          // Simplest way to retrieve the provided value.
          //
          // Each time the counter changes, this will get rebuilt. This widget
          // requires the value to be a Listenable or a Stream. Otherwise
          Provide<Counter>(
            builder: (context, child, counter) => Text('${counter.value}'),
          ),

          // This widget gets the counter as a stream of changes.
          // The stream is filtered so that this only rebuilds on even numbers.
          StreamBuilder<Counter>(
              initialData: currentCounter,
              stream: Provide.stream<Counter>(context)
                  .where((counter) => counter.value % 2 == 0),
              builder: (context, snapshot) =>
                  Text('Last even value: ${snapshot.data.value}')),

          // This button just needs to call a method on Counter. No need to rebuild
          // it as the value of Counter changes. Therefore, we can use the value of
          // `Provide.value<Counter>` from above.
          FlatButton(
              child: Text('increment'), onPressed: currentCounter.increment),

          Text('Another widget that does not depend on the Counter'),
        ]),
      ),
    );
  }
}

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
//      ProviderDemo(),
    );
  }
}

class ProviderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Provide状态管理器(Google亲儿子)")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Number(), Add()],
        ),
      ),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "0",
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }
}

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Text("加一"),
      ),
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
