import 'package:flutter/material.dart';

class alert extends StatelessWidget {
  const alert({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    void showAlertDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Alert !!!!'),
          content: Text('Are you sure....'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }

    void showAlert() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Tittle page'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.warning, color: Colors.red, size: 40),
                  SizedBox(height: 30),
                  Text(
                    'Alert',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'My name is  Bhadan. I am a student from ICST.I live in Noakhali',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }

    void simpleDialogBox() {
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text('Simple Dialog Box'),
          children: [
            SimpleDialogOption(child: Text('Option-1')),
            SimpleDialogOption(
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.abc_sharp),
                  hintText: 'Text field',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    void showBottomSheetAlert() {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          child: Column(
            children: [
              Text(
                'Choose option',
                style: TextStyle(color: Colors.amber, fontSize: 30),
              ),
              ListTile(
                title: Text('Option-1'),
                onTap: () {
                  Navigator.pop(context);
                },
                onLongPress: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Option-2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(title: Text('Option-3')),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {}, child: Text('Save')),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Alert Box'), centerTitle: true),
      body: Padding(
        padding: EdgeInsetsGeometry.all(100),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          
            children: [
              Container(
                color: Colors.amber,
                height: screenSize.height*0.5,
                width: screenSize.width*0.3,
              ),
              SizedBox(height: 20),
              Text(
                'Alert Box',
                style: TextStyle(fontSize: screenSize.width >600 ?30 :20,
                fontWeight: FontWeight.bold),
              ),
          
             SizedBox(height: 20),
             
              ElevatedButton(
                onPressed: () {
                  showAlertDialog();
                },
                child: Text('Alert Box'),
              ),
          
              ElevatedButton(
                onPressed: () {
                  showAlert();
                },
                child: Text('Alert Box'),
              ),
              ElevatedButton(
                onPressed: () {
                  simpleDialogBox();
                },
                child: Text('Simple dialog Box'),
              ),
          
              ElevatedButton(
                onPressed: () {
                  showBottomSheetAlert();
                },
                child: Text('Show Bottom Sheet Alert'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
