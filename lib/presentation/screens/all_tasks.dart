import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_2/presentation/screens/new_tasks.dart';
import 'package:task_2/presentation/widgets/buildtaskitem.dart';

import '../../business_logic/cubit/todo_cubit.dart';

class AllTasksScreen extends StatefulWidget {
  AllTasksScreen({Key? key}) : super(key: key);

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  late Database database;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    
        return BlocConsumer<TodoCubit, TodoState>(
          listener: (context, state) {
            // TODO: implement listener

          },
          builder: (context, state) {
            
            var tasks = TodoCubit.get(context).allTasks;
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
                        itemCount: TodoCubit.get(context).allTasks.length),
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
