import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/shared/cubit/cubit_observe.dart';

import 'layout/home.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TodoHome());
  }
}
