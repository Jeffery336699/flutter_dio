import 'counter.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class ProviderDemo extends StatefulWidget {
  @override
  _ProviderDemoState createState() => _ProviderDemoState();
}

class _ProviderDemoState extends State<ProviderDemo> {
  var providers;

  @override
  void initState() {
    super.initState();
    providers = Providers()
      ..provide(Provider.function((context) => Counter(0)));
  }

  @override
  Widget build(BuildContext context) {
    return ProviderNode(
      providers: providers,
      child: MaterialApp(
        home: CounterApp(),
      ),
    );
  }
}

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {

  @override
  Widget build(BuildContext context) {
    final currentCounter = Provide.value<Counter>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Provider"),
      ),
      body: Column(children: [
        Provide<Counter>(
          builder: (context, child, counter) => Text('${counter.value}'),
        ),
        StreamBuilder<Counter>(
            initialData: currentCounter,
            stream: Provide.stream<Counter>(context)
                .where((counter) => counter.value % 2 == 0),
            builder: (context, snapshot) =>
                Text('Last even value: ${snapshot.data.value}')),
        FlatButton(
            child: Text('increment'), onPressed: currentCounter.increment),

        Text('Another widget that does not depend on the Counter'),
      ]),
    );
  }
}
