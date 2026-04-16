import 'package:flutter/material.dart';

class ListV extends StatefulWidget {
  final int number;
  const ListV({super.key, required this.number});

  @override
  State<ListV> createState() => _ListVState();
}

class _ListVState extends State<ListV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List View')),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.person),
              trailing: Icon(Icons.call),
                title: Text('Bhadan Paul',style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('${widget.number}'),
            ),
          );
        },
      ),
    );
  }
}
