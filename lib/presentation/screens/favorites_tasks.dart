import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/presentation/screens/new_tasks.dart';
import 'package:task_2/presentation/widgets/buildtaskitem.dart';

import '../../business_logic/cubit/todo_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
          listener: (context, state) {
            // TODO: implement listener

          },
          builder: (context, state) {
            
            var tasks = TodoCubit.get(context).favoriteTasks;
            print(tasks);

            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            BuildTaskItem(tasks[index],context),
                        separatorBuilder: (context, index) => Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[300],
                            ),
                        itemCount: TodoCubit.get(context).favoriteTasks.length),
                    Container(
                        padding: const EdgeInsetsDirectional.all(20),
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NewTasks()));
                            },
                            child: Text('Add a task')))
                  ],
                ),
              ),
            );
          },
        );
  }
}