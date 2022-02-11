import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'httpapi.dart';



void main() {
  runApp(const MyApp());
}

//ErgoHttpApi httpApi = ErgoHttpApi(baseUrl: 'https://cloudmatic.one/shadow_tests/api.php/', connectTimeout: 5000, receiveTimeout: 3000);
ErgoHttpApi myHttp = ErgoHttpApi(baseUrl: 'http://192.168.1.172/api.php/', connectTimeout: 5000, receiveTimeout: 3000);


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
       const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Map<String, dynamic> parameters = {
    'Indeks': 'jakas nazwa',
    'Nazwa': 'jakis kod',
    'Kod klienta': 'jakis kod klienta'
  };

  List<TextEditingController> textField_controller = []; //  = {} as List<TextEditingController>;


  //List<TextEditingController> _controller = List.generate(74, (i) => TextEditingController());

//List<String> parameters = ['jeden', 'dwa', 'trzy', 'cztery'];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    var _values = parameters.values.toList();
    var _keys = parameters.keys.toList();

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: parameters.length,
        itemBuilder: (context, index) {
          TextEditingController _controller = new TextEditingController();
          textField_controller.add(_controller);
          //textField_controller[0].text = 'test';
          //_controller.text = 'test';

          return Row(children: [
            Column(
              children: [
                Text(_keys[index]),
              ],
            ),
            Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 150,
                      child: TextField(
                        controller: textField_controller[index],
                      ),
                    ),
                  ],
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    onSurface: Colors.red,
                  ),
                  onPressed: () => {
                     //
                    //print('{"id_etykieta_definicja":null,"kod_program":"${textField_controller[0].text}","nazwa":"${textField_controller[1].text}","kod_produkt":"${textField_controller[2].text}"}')
                    print( myHttp.request(path: '/records/produkt', data: '{"id_etykieta_definicja":null,"kod_program":"${textField_controller[0].text}","nazwa":"${textField_controller[1].text}","kod_produkt":"${textField_controller[2].text}"}', method: 'POST'))
                    //print(textField_controller[index].text)

                  },
                  child: Text(_values[index]),
                )
              ],
            ),
          ]);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Floating Button',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
