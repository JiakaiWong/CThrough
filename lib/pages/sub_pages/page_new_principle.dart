import 'package:flutter/material.dart';

class NewPrinciplePage extends StatefulWidget {
  @override
  _NewPrinciplePageState createState() => _NewPrinciplePageState();
}

class _NewPrinciplePageState extends State<NewPrinciplePage> {
  List<bool> checkboxesForConsumptivePower = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Principle'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              
              TextField(
                decoration: InputDecoration(
                    hintText: 'Principle',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    )),
                maxLength: 100,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Description',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
                maxLength: 100,
              ),
              
              
              
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      'Done',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
