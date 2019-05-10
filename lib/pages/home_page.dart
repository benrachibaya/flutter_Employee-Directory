import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:employee_directory/models/employee.dart';
import 'dart:convert';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Employees List")),
      body: new Center(child: new MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  //final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Employee>> _getEmployees() async {
    var data = await http
        .get("http://www.json-generator.com/api/json/get/bQysixTOEO?indent=2");

    var jsonData = json.decode(data.body);

    List<Employee> employees = [];

    for (var u in jsonData) {
      Employee emp = Employee(u['name'], u['phone'], u['address'], u['email'],
          u['picture'], u['company']);
      employees.add(emp);
    }
    print(employees.length);
    return employees;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
          child: FutureBuilder(
        future: _getEmployees(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(child: Center(child: Text("Loading...")));
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data[index].picture)),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].phone),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data[index])));
                    });
              },
            );
          }
        },
      )),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Employee emp;
  DetailPage(this.emp);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(emp.name)),
        body: Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: [
                  Icon(Icons.phone),
                  Text(emp.phone),
                ]),
                Row(children: [
                  Icon(Icons.email),
                  Text(emp.email),
                ]),
                Row(children: [
                  Text("Company: "),
                  Text(emp.company),
                ]),
                Text('address:  ' + emp.address),
              ]),
        ));
  }
}
