import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'my_app.dart';
import 'observer.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

