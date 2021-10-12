import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/cubit/componants/reuseable.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newtasks;
        return ListView.separated(
            itemBuilder: (context, index) =>
                DismissibleComp(context, tasks, index),
            separatorBuilder: (context, index) => Divider(),
            itemCount: tasks.length);
      },
    );
  }
}
