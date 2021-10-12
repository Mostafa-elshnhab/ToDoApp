import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/layout/Archive.dart';
import 'package:todoapp/layout/Done.dart';
import 'package:todoapp/layout/tasks.dart';
import 'package:todoapp/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppinitState());
  static AppCubit get(context) => BlocProvider.of(context);
  int current = 0;
  final List<Widget> Pages = [Tasks(), Done(), archive()];
  final List<String> titles = ['New Tasks', 'Done Tasks', 'Archive Tasks'];
  void changeIndex(index) {
    current = index;
    emit(BotomNavChangeState());
  }

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  void CreateDAtapase() {
    openDatabase(
      'todo.dp',
      version: 1,
      onCreate: (db, version) {
        db
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, data TEXT, time TEXT,status TEXT)')
            .then((value) => print('table created'))
            .catchError((onError) {
          print('Erorr When create table$onError');
        });
      },
      onOpen: (db) {
        getData(db);

        print('database Opend');
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  void Insertdatapase(title, date, time) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks (title,data,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print('$value data inserted');
        emit(insertDatabaseState());
        getData(database);
      }).catchError((onError) {
        print('error when insert in table $onError');
      });
    });
  }

  getData(db) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];
    db.rawQuery('SELECT * FROM tasks')
      ..then((value) {
        value.forEach((element) {
          if (element['status'] == 'new')
            newtasks.add(element);
          else if (element['status'] == 'done')
            donetasks.add(element);
          else
            archivetasks.add(element);
        });
        emit(getDatabaseState());
      });
  }

  void UpdateDatabase({required String status, required int id}) {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [
      '$status',
      id,
    ]).then((value) {
      emit(UpdateDatabaseState());
      getData(database);
    });
  }

  void deleteDatabase({required int id}) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(deleteDatabaseState());
      getData(database);
    });
  }

  Database? database;
  bool isbottomSheet = false;
  void changebottomSheet(bool isSheet) {
    isbottomSheet = isSheet;
    emit(BotomshetChangeState());
  }
}
