import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/business_logic/cubit/todo_cubit.dart';
import 'package:task_2/presentation/screens/homepage.dart';
import 'package:task_2/app_routing.dart';

import 'app_routing.dart';
import 'constants/block_observers.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  final AppRouter appRouter;
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
