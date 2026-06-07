import 'package:flutter/material.dart';
class taskCountStatusBar extends StatelessWidget {
  const taskCountStatusBar({
    super.key, required this.tittle, required this.count,
  });
  final String tittle;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.greenAccent.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 8),
        child: Column(
          children: [
            Text('$count',style: Theme.of(context).textTheme.titleLarge,),
            Text(tittle,style: TextStyle(color: Colors.black),),

          ],
        ),
      ),
    );
  }
}