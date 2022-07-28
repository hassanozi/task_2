

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_2/constants/strings.dart';
import 'package:task_2/presentation/screens/homepage.dart';
import 'package:task_2/presentation/screens/new_tasks.dart';

class AppRouter{
  Route? generateRoute(RouteSettings settings){
    switch (settings.name) {
      case homescreen:
         return MaterialPageRoute(builder: (_) => HomePage());
      case newtaskscreen:
         return MaterialPageRoute(builder: (_) => NewTasks());
    }
  }
}