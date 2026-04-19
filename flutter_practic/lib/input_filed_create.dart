
import 'package:flutter/material.dart';

class InputFiled extends StatelessWidget {
const InputFiled({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController UsernameController = TextEditingController();
    TextEditingController PasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login From',style: TextStyle(color: Colors.blueGrey,fontSize: 25,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: UsernameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Enter your username',
                labelText: 'Username',
                prefixIcon: Icon( Icons.person),
                suffixIcon: Icon(Icons.check_circle),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              
            ),
          ),

           Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: PasswordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                labelText: 'Password',
                prefixIcon: Icon( Icons.lock),
                suffixIcon: Icon(Icons.check_circle),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              
            ),
          ),

          SizedBox(height: 20),

          SizedBox(
            child: ElevatedButton(onPressed: () {
              if(UsernameController.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter your username'))
                );
                
              }else if(UsernameController.text.length < 6){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Username must be at least 6 characters long'))
                );
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login successful'))
                );
              }
            }, child: Text('Login')),
          ),
          
        ],
      ),

    );
  }
}