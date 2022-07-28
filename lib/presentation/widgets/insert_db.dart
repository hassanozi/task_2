import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

// Future insertToDatabase({required String title,required String date,required String starttime,required  String endtime,required  String reminder}) async{
//    Database database;

//   return await database.transaction((txn) 
//   {
//     txn.rawInsert('INSERT into tasks (title,date,starttime,endtime,reminder,status) VALUES ("$title","$date","$starttime","$endtime","$reminder","new")').then((value) {
//       print('$value inserted');
//     }).catchError((error){
//       print('Error when inserting new record ${error.toString()}');
//     });

//     return Future<Null>(() {});  
//   });
// }
