import 'package:flutter/material.dart';

import '../cubit.dart';

Widget DismissibleComp(context, tasks, index) => Dismissible(
      key: Key('${tasks[index]['id'].toString()}'),
      onDismissed: (direction) {
        AppCubit.get(context).deleteDatabase(id: tasks[index]['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 35,
                child: Text('${tasks[index]['time']}'),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${tasks[index]['title']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text('${tasks[index]['data']}'),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .UpdateDatabase(status: 'done', id: tasks[index]['id']);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.teal,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context).UpdateDatabase(
                      status: 'archive', id: tasks[index]['id']);
                },
                icon: Icon(
                  Icons.archive_rounded,
                  color: Colors.black54,
                ))
          ],
        ),
      ),
    );
