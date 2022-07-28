import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_2/business_logic/cubit/todo_cubit.dart';


Widget BuildTaskItem(Map model,context) {

  return Dismissible(
    key: Key(model['id'].toString()),
    child: Material(
      child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Text('${model['starttime']}'),
                  ), SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${model['title']}',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        Text('${model['date']}',style: TextStyle(color: Colors.grey),)
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  IconButton(onPressed: (){
                      TodoCubit.get(context).updateData(type: 'done', id: model['id']);
                  }, icon: Icon(Icons.done)),
                  IconButton(onPressed: (){
                    TodoCubit.get(context).updateData(type: 'incomplete', id: model['id']);
                  }, icon: Icon(Icons.incomplete_circle)),
                  IconButton(onPressed: (){
                    TodoCubit.get(context).updateData(type: 'favorite', id: model['id']);
                  }, icon: Icon(Icons.favorite)),
                ],
              ),
            ),
    ),
    onDismissed: (direction){
      TodoCubit.get(context).deleteData(id: model['id']);
    },
  );
} 