import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/center_progress_indegator.dart';
import 'package:task_manager_app/ui/widgets/ShowSnackbarMessage.dart';
class task_card_widget extends StatefulWidget {
  const task_card_widget({
    super.key, required this.text, required this.taskModel, required this.refreshParent,
  });
  final String text;
  final TaskModel taskModel;
  final VoidCallback refreshParent;

  @override
  State<task_card_widget> createState() => _task_card_widgetState();
}

class _task_card_widgetState extends State<task_card_widget> {
  bool _changeStatusInProgress = false;
  bool _deleteTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: Theme.of(context).cardColor,
      title: Text(widget.taskModel.tittle),
      subtitle: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.taskModel.description),
          Text('${widget.taskModel.createdAt}',style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color,fontWeight: FontWeight.w600),),
          Row(
            children: [
              Chip(
                label: Text(widget.taskModel.status),
                labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                backgroundColor: Colors.greenAccent.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              Spacer(),
              Visibility(
                visible: _deleteTaskInProgress == false,
                replacement: Center_progress_indegator(),
                child: IconButton(
                  onPressed: () {
                    _deleteTaskDialog();
                  },
                  icon: const Icon(Icons.delete, color: Colors.grey),
                ),
              ),
              Visibility(
                visible: _changeStatusInProgress == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: IconButton(onPressed: () {
                  _showChangeStatusDialog();
                }, icon: Icon(Icons.edit,color: Colors.grey,)),
              ),

            ],
          )
        ],
      ),
    );
  }

  void _showChangeStatusDialog(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Change Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                _changeStatus('New');
              },
              title: Text('New'),
              trailing: widget.taskModel.status == 'New' ? Icon(Icons.done) : null,
            ),
            ListTile(
              onTap: () {
                _changeStatus('Progress');
              },
              title: Text('Progress'),
              trailing: widget.taskModel.status == 'Progress' ? Icon(Icons.done) : null,
            ),
            ListTile(
              onTap: () {
                _changeStatus('Cancelled');
              },
              title: Text('Cancelled'),
              trailing: widget.taskModel.status == 'Cancelled' ? Icon(Icons.done) : null,
            ),
            ListTile(
              onTap: () {
                _changeStatus('Completed');
              },
              title: Text('Completed'),
              trailing: widget.taskModel.status == 'Completed' ? Icon(Icons.done) : null,
            ),
          ],
        ),
      );
    });
  }

  void _deleteTaskDialog(){
    showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text('Delete Task'),
        content: Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancel')),
          TextButton(onPressed: (){
            Navigator.pop(context);
            _deleteTask();
          }, child: Text('Delete')),
        ],
      );
    });
  }
  Future<void> _changeStatus (String status) async{
    if(status == widget.taskModel.status){
      return;
    }
    Navigator.pop(context);
    _changeStatusInProgress = true;
    setState(() {});
    ApiResponse response = await ApiCaller.getRequest(url: Urls.updateTaskStatusUrl(widget.taskModel.id, status));
    _changeStatusInProgress = false;
    setState(() {});
    if(response.isSuccess){
     widget.refreshParent();

    }else{
      ShowSnackbarMessage('Task Manager App', response.errorMassage!);
    }
  }
  Future<void> _deleteTask () async{
    _deleteTaskInProgress = true;
    setState(() {});
    ApiResponse response = await ApiCaller.getRequest(url: Urls.deleteTaskUrl(widget.taskModel.id));
    _deleteTaskInProgress = false;
    setState(() {});
    if(response.isSuccess){
     widget.refreshParent();

    }else{
      ShowSnackbarMessage('Task Manager App', response.errorMassage!);
    }
  }
}
