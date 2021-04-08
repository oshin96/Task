import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String name, lastname, email, age, image, address, salary, mob;

  const DetailPage(
      {Key key,
      this.name,
      this.lastname,
      this.email,
      this.age,
      this.image,
      this.address,
      this.salary,
      this.mob})
      : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("DETAILS"),
      ),
      body: Container(
        child: Column(children: [
          SizedBox(
            height: 20.0,
          ),
          Image.network(widget.image),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),),
                      ),
                      Text(widget.lastname,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),)
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Age : " + widget.age.toString()),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Salary : " + widget.salary.toString()),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
