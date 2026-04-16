import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_practic/list_view.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Facebook',
          style: TextStyle(color: Colors.blue, fontSize: 50),
        ),
        centerTitle: true,
        backgroundColor: Colors.white30,
      ),
      body: Column(
        children: [
          Image.asset(
            'asset/—Pngtree—facebook social media icon_4235822.png',
            height: 200,
            width: 200,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,

                  decoration: InputDecoration(
                    suffix: Icon(Icons.phone),
                    
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (value.length != 11) {
                      return 'Please enter a valid 11-digit phone number';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffix: Icon(Icons.visibility),
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListV(number: int.parse(phoneNumberController.text)),
                          ),
                        );
                      }
                      // Handle login logic here
                    },
                    child: Text('Log In'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
