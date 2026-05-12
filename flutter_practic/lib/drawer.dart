import 'package:flutter/material.dart';
import 'icon.dart';
import 'image_login_form.dart';
import 'list_view.dart';

class DrawerV extends StatelessWidget {
  const DrawerV({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home page'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.login), text: 'Login',),
              Tab(icon: Icon(Icons.list), text: 'Icon list'),
            ],
          ),
          
        ),
        body: TabBarView(
          children: [
            Login (),
            practic (),
          ],
          
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/198579047?s=400&u=87b45b5ab70bf58ba481297207006fe7634082a2&v=4',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Bhadan Paul',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'bhadanpaul@gmail.com',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 3, vertical: -4),
                dense: true,
                title: Text('Home'),
                onTap: () {},
              ),
      
              Divider(color: Colors.blueGrey, thickness: 1),
      
              ListTile(
                visualDensity: VisualDensity(horizontal: 3, vertical: -4),
                dense: true,
                title: Text('Setting'),
                onTap: () {},
              ),
              Divider(color: Colors.blueGrey, thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}
