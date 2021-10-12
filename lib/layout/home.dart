import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class TodoHome extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  var tasksControler = TextEditingController();
  var timeControler = TextEditingController();
  var dateControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    formKey != GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => AppCubit()..CreateDAtapase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          print('mostafa');
          if (state is getDatabaseState) {
            print('ssadasdasasasas');
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.current,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    size: 30,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                    size: 30,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                    size: 30,
                  ),
                  label: 'archive',
                ),
              ],
            ),
            appBar: AppBar(
              title: Text(cubit.titles[cubit.current]),
              centerTitle: true,
            ),
            body: cubit.Pages[cubit.current],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isbottomSheet) {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    cubit.changebottomSheet(false);
                    cubit.Insertdatapase(tasksControler.text,
                        dateControler.text, timeControler.text);
                    tasksControler.clear();
                    dateControler.clear();
                    timeControler.clear();
//              setState(() {
//                Insertdatapase(tasksControler.text, dateControler.text,
//                    timeControler.text);
//                isbottomSheet = false;
//              });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) => Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Tasks filed is requred';
                                      }
                                      return null;
                                    },
                                    controller: tasksControler,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        labelText: 'Title',
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.title)),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Time filed is requred';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) => timeControler.text =
                                              value!
                                                  .format(context)
                                                  .toString());
                                    },
                                    controller: timeControler,
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                        labelText: 'Time',
                                        border: OutlineInputBorder(),
                                        prefixIcon:
                                            Icon(Icons.watch_later_outlined)),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Date filed is requred';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2021-10-30'))
                                          .then((value) => dateControler.text =
                                              DateFormat.yMMMd()
                                                  .format(value!));
                                    },
                                    controller: dateControler,
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                        labelText: 'Date',
                                        border: OutlineInputBorder(),
                                        prefixIcon:
                                            Icon(Icons.date_range_outlined)),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.changebottomSheet(false);

//              setState(() {
//                isbottomSheet = false;
//              });
                  });
                  cubit.changebottomSheet(true);
                }
              },
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
