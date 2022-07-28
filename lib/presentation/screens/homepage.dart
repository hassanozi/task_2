import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_2/business_logic/cubit/todo_cubit.dart';
import 'package:task_2/presentation/screens/all_tasks.dart';
import 'package:task_2/presentation/screens/completed_tasks.dart';
import 'package:task_2/presentation/screens/favorites_tasks.dart';
import 'package:task_2/presentation/screens/new_tasks.dart';
import 'package:task_2/presentation/screens/uncomplete_tasks.dart';
import 'package:task_2/presentation/widgets/bell_alert.dart';
import 'package:path/path.dart';
import '../../constants/strings.dart';
import '../widgets/data_db.dart';

class HomePage extends StatelessWidget {

//  late Database database;
  var Scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {

          TodoCubit cubit = TodoCubit.get(context);
          
          return DefaultTabController(
            length: cubit.tabs.length,
            child: Scaffold(
              key: Scaffoldkey,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 3,
                  bottom: TabBar(
                    onTap: (index) {
                      // setState(() {
                       cubit.changeIndex(index) ;
                      // });
                      
                    },
                    tabs: [
                      Text(cubit.tabs[0],style: TextStyle(fontWeight:cubit.tabBarIndex == 0 ? FontWeight.bold : null,
                      color: cubit.tabBarIndex == 0? Colors.black: Color(0xFFC1BDBB),fontSize: cubit.tabBarIndex == 0 ? 12 : null)),
          
                      Text(cubit.tabs[1], style: TextStyle(fontWeight:cubit.tabBarIndex == 1 ? FontWeight.bold : null,
                      color:cubit.tabBarIndex == 1? Colors.black: Color(0xFFC1BDBB),fontSize:cubit.tabBarIndex == 1 ? 12 : null)),

                      Text(cubit.tabs[2],style: TextStyle(fontWeight: cubit.tabBarIndex == 2 ? FontWeight.bold : null,
                      color: cubit.tabBarIndex == 2 ? Colors.black : Color(0xFFC1BDBB),fontSize: cubit.tabBarIndex == 2 ? 12 : null)),

                      Text(cubit.tabs[3], style: TextStyle(fontWeight:cubit.tabBarIndex == 2 ? FontWeight.bold : null,
                      color: cubit.tabBarIndex == 3 ? Colors.black: Color(0xFFC1BDBB),fontSize: cubit.tabBarIndex == 3 ? 12 : null)),
                    ],
                    
                  ),
                  title: Text(cubit.titles[cubit.tabBarIndex],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.black,
                            ))),
                    IconButton(
                      onPressed: () {},
                      icon: mybellIcon(),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.menu,
                              size: 20,
                              color: Colors.black,
                            ))),
                  ],
                ),   
                // cubit.screens[tabBarIndex]
                body: ConditionalBuilder(
                  condition: state is !TodoGetDatabaseLoadingState, builder: (context)=> cubit.screens[cubit.tabBarIndex], fallback: (context)=>Center(child: CircularProgressIndicator()),),
                  
            ),
          );
        },
      ),
    );
  }

  
}

