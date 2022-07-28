import 'package:sqflite/sqflite.dart';

class databasesProfile {
  late Database database;

  void createDatabase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
      print('created');
      database
          .execute(
              'create table tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, starttime TEXT, endtime TEXT,reminder TEXT, status TEXT)')
          .then((value) => value)
          .catchError((error) {
        print('Error when creating table ${error.toString()}');
      });
    }, onOpen: (database) {
      print('opend');
    });
  }

  Future insertToDatabase(
      {required String title,
      required String date,
      required String starttime,
      required String endtime,
      required String reminder}) async {
    //  Database database;

    return await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT into tasks (title,date,starttime,endtime,reminder,status) VALUES ("$title","$date","$starttime","$endtime","$reminder","new")')
          .then((value) {
        print('$value inserted');
      }).catchError((error) {
        print('Error when inserting new record ${error.toString()}');
      });

      return Future<Null>(() {});
    });
  }
}
