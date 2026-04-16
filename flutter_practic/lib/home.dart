import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[700],
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Text('my name is flutter', style: TextStyle(color: const Color.fromARGB(218, 247, 2, 2),fontSize: 200,fontWeight: FontWeight.bold)),

            Text('my name is flutter', style: TextStyle(color: const Color.fromARGB(255, 252, 1, 1),fontSize: 200)),
            Text('my name is flutter', style: TextStyle(color: const Color.fromARGB(255, 253, 3, 3),fontSize: 200)),
            Text('my name is flutter', style: TextStyle(color: const Color.fromARGB(255, 250, 2, 2),fontSize: 20)),
            Text('my name is flutter', style: TextStyle(color: const Color.fromARGB(255, 248, 1, 1),fontSize: 20)),
            Text('my name is flutter', style: TextStyle(color: const Color.fromARGB(255, 247, 1, 1),fontSize: 20)),
            Text('my name is flutter', style: TextStyle(color: const Color.fromARGB(255, 250, 3, 3),fontSize: 20)),
            Text('my name is flutter', style: TextStyle(color: const Color.fromARGB(255, 247, 3, 3),fontSize: 20)),
            Text('my name is flutter', style: TextStyle(color: const Color.fromARGB(255, 249, 3, 3),fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
