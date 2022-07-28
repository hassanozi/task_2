part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoChangeTabBarState extends TodoState{}

class TodoCreateDatabaseState extends TodoState{}

class TodoGetDatabaseState extends TodoState{}

class TodoGetDatabaseLoadingState extends TodoState{}

class TodoUpdateDatabaseState extends TodoState{}

class TodoDeleteDatabaseState extends TodoState{}

class TodoInsertDatabaseState extends TodoState{}

