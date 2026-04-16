import 'dart:math';

import 'package:flutter/material.dart';

class practic extends StatelessWidget {
  const practic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Icon Page'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(Icons.home, size: 100, color: Colors.red),
            Icon(Icons.favorite, size: 100, color: Colors.pink),
            Icon(Icons.star, size: 100, color: Colors.yellow),
            Icon(Icons.settings, size: 100, color: Colors.blueGrey),
            Icon(Icons.phone, size: 100, color: Colors.green),
            Icon(Icons.email, size: 100, color: Colors.orange),
            Icon(Icons.camera_alt, size: 100, color: Colors.purple),
            Icon(Icons.shopping_cart, size: 100, color: Colors.brown),
            Icon(Icons.music_note, size: 100, color: Colors.cyan),
            SizedBox(height: 200, width: double.infinity),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 245, 4, 4),
                foregroundColor: Colors.white,
                // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                print('complete');
              },
              child: Text(
                'Press Me',
                style: TextStyle(
                  color: const Color.fromARGB(255, 241, 241, 242),
                ),
              ),
            ),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                print('complete');
              },
              child: Text('click me'),
            ),

            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                print('complete');
              },
              child: Text('code complet'),
            ),

            GestureDetector(
              onTap: () {
                print('complete');
              },
              child: Text(
                'Tap me',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            InkWell(
              onTap: () {
                print('complete');
              },

              child: Text(
                'change me',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
