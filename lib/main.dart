import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_login_demo/services/auth_services.dart';

import 'models/authentication_request.dart';
import 'services/my_https_override.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  late final AuthServices _services;

  @override
  void initState() {
    _services = AuthServices();
    super.initState();
  }

  final txtUserName = TextEditingController(
    text: '888C000351',
  );
  final txtPassword = TextEditingController(
    text: 'hello1',
  );

  dynamic result;

  login() async {
    Map<String, dynamic> json = <String, dynamic>{};
    // Map<String, dynamic> headers = <String, dynamic>{};
    json = <String, dynamic>{
      "username": txtUserName.text,
      "password": txtPassword.text,
      // "headers": headers,
    };
    try {
      inspect(await _services.authenticate(AuthenticateRequest.fromJson(json)));
    } catch (e) {
      print('login $e');
    }

    // headers = {
    //   'token': {
    //     'ud': {
    //       'u': authRes.id,
    //       'sid': authRes.sessionId,
    //     }
    //   }
    // };
    // print(json);
    // print(headers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (result != null) Text(result),
            TextField(controller: txtUserName),
            const SizedBox(height: 20),
            TextField(controller: txtPassword),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => login(),
              icon: const Icon(Icons.login),
              label: const Text('Đăng nhập'),
            ),
            IconButton(
              onPressed: _services.loginGoogle,
              icon: const Icon(
                Icons.login,
              ),
            ),
            IconButton(
              onPressed: _services.logout,
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
