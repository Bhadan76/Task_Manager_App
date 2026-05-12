

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class button_widget extends StatelessWidget {
  final int amount;
  IconData ? icon;
  final VoidCallback onClick;
   button_widget({
    super.key, required this.amount, required this.onClick,this.icon
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton.icon(
          onPressed: onClick,
          icon: Icon(icon ?? Icons.water_drop,color: Colors.blue,),
          label: Text('+$amount LTR ',style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}