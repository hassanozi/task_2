import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:task_2/business_logic/cubit/todo_cubit.dart';
import 'package:task_2/presentation/screens/homepage.dart';

import '../widgets/data_db.dart';

class NewTasks extends StatefulWidget {
  NewTasks({Key? key}) : super(key: key);

  static String id = 'newTasks';

  @override
  State<NewTasks> createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  final titleController = TextEditingController();

  final dateController = TextEditingController();

  final starttimeController = TextEditingController();

  final endtimeController = TextEditingController();

  final reminderController = TextEditingController();

  // final repeatController = TextEditingController();

  // final statusController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  

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
        if (state is TodoInsertDatabaseState) {
           Navigator.of(context).push(MaterialPageRoute(
           builder: (context) => HomePage()));
           

        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('New Task')),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'New Task',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (value) {
                          print(value);
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Title must not be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Tilte',
                          prefixIcon: Icon(Icons.text_fields),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101))
                              .then((value) {
                            var formattedDate =
                                "${value!.day}/${value.month}/${value.year}";
                            dateController.text = formattedDate.toString();
                          });
                        },
                        onFieldSubmitted: (value) {
                          print(value);
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Date must not be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Deadline',
                          prefixIcon: Icon(Icons.date_range),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: starttimeController,
                        keyboardType: TextInputType.datetime,
                        onTap: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: const TimeOfDay(
                                      hour: TimeOfDay.hoursPerDay,
                                      minute: TimeOfDay.minutesPerHour))
                              .then((value) {
                            starttimeController.text = value!.format(context);
                          });
                        },
                        onFieldSubmitted: (value) {
                          print(value);
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Start Time must not be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Start time',
                          prefixIcon: Icon(Icons.timer_sharp),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: endtimeController,
                        keyboardType: TextInputType.datetime,
                        onTap: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: const TimeOfDay(
                                      hour: TimeOfDay.hoursPerDay,
                                      minute: TimeOfDay.minutesPerHour))
                              .then((value) {
                            endtimeController.text =
                                value!.format(context).toString();
                          });
                        },
                        onFieldSubmitted: (value) {
                          print(value);
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'End Time must not be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'End time',
                          prefixIcon: Icon(Icons.timer_sharp),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: double.infinity,
                        child: DropdownButton(
                          // Initial Value
                          value: TodoCubit.get(context).dropdownvalue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            
                              TodoCubit.get(context).dropdownvalue = newValue!;
                            
                          },

                          // Array list of items
                          items: TodoCubit.get(context).reminderItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: double.infinity,
                        child: DropdownButton(
                          // Initial Value
                          value: TodoCubit.get(context).repeatedItemValue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            
                              TodoCubit.get(context).repeatedItemValue = newValue!;
                            
                          },

                          // Array list of items
                          items: TodoCubit.get(context).repeatItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              TodoCubit.get(context)
                                  .insertToDatabase(
                                      title: titleController.text,
                                      date: dateController.text,
                                      starttime: starttimeController.text,
                                      endtime: endtimeController.text,
                                      reminder: TodoCubit.get(context).dropdownvalue,
                                      repeat : TodoCubit.get(context).repeatedItemValue)
                                  .then((value) {
                                // titleController.text = '';
                                // dateController.text = '';
                                // starttimeController.text = '';
                                // endtimeController.text = '';
                                
                                
                               
                              });

                              // print(titleController.text);
                              // print(dateController.text);
                            }
                          },
                          child: const Text(
                            'ADD',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text('don\'t have an account'),
                      //     TextButton(onPressed: (){
                      //       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MessengerScreen()));
                      //     }, child: Text('Resister Now'))
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Future insertToDatabase(
  //     {required String title,
  //     required String date,
  //     required String starttime,
  //     required String endtime,
  //     required String reminder}) async {
  //   //  Database database;

  //   return await database.transaction((txn) {
  //     txn
  //         .rawInsert(
  //             'INSERT into tasks (title,date,starttime,endtime,reminder,status) VALUES ("$title","$date","$starttime","$endtime","$reminder","new")')
  //         .then((value) {
  //       print('$value inserted');
  //       // getDataFromDatabase(database).then((value){

  //       // });
  //     }).catchError((error) {
  //       print('Error when inserting new record ${error.toString()}');
  //     });

  //     return Future<Null>(() {});
  //   });
  // }

  // void createDatabase() async {
  //   database = await openDatabase('todo.db', version: 1,
  //       onCreate: (database, version) {
  //     print('created');
  //     database
  //         .execute(
  //             'create table tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, starttime TEXT, endtime TEXT,reminder TEXT, status TEXT)')
  //         .then((value) => value)
  //         .catchError((error) {
  //       print('Error when creating table ${error.toString()}');
  //     });
  //   }, onOpen: (database) {
  //     print('opend');
  //   });
  // }

}
