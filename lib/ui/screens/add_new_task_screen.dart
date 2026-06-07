import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/app_bar_widget.dart';
import 'package:task_manager_app/ui/widgets/showSnackBarMessage.dart';
class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});
  static const String name= 'add new task screen';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _tittleController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
   bool addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar_widget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox(height: 40,),
               Text('Add New Task',style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: 24,),
              TextFormField(
                controller: _tittleController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Tittle',
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty?? true){
                    return 'Enter your tittle';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: _descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty?? true){
                    return 'Enter your description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32,),
              Visibility(
                visible: addNewTaskInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: FilledButton(
                  onPressed: _onTapAddNewText, child: Text('Add'))),
            ],
          ),
        ),
      ),
    );
  }
  void _onTapAddNewText(){
    if(_formKey.currentState!.validate()){
        addNewTask();

    }
  }
  Future<void> addNewTask() async {
    addNewTaskInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody ={
      "title":_tittleController.text.trim(),
      "description":_descriptionController.text.trim(),
      "status":"New"
    };
    ApiResponse response= await ApiCaller.postRequest(url: Urls.createTaskUrl,body: requestBody);
    addNewTaskInProgress = false;
    setState(() {});
    if(response.isSuccess){
     addTaskClear();
     if (mounted) {
       Showsnackbarmessage(context, 'New task added');
       Get.back(result: true);
     }
    }else{
      Showsnackbarmessage(context, response.errorMassage!);
    }
  }
  void addTaskClear(){
    _tittleController.clear();
    _descriptionController.clear();
  }
  @override
  void dispose() {
   _tittleController.dispose();
   _descriptionController.dispose();
    super.dispose();
  }
}



