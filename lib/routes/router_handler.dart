import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_dio/pages/user_screen.dart';

var usersHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserScreen(id:params["id"]?.first);
});