import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DetailPage extends StatefulWidget {
  final String name,
      lastname,
      email,
      age,
      image,
      address,
      salary,
      mob,
      birthDate;

  const DetailPage(
      {Key key,
      this.name,
      this.lastname,
      this.email,
      this.age,
      this.image,
      this.address,
      this.salary,
      this.mob,
      this.birthDate})
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
        child: details(),
      ),
    );
  }

  Widget details() {
    return Column(
        children: [
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
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26.0),
                        ),
                      ),
                      Text(
                        widget.lastname,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26.0),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(FontAwesome.location_arrow, size: 14.0),
                        Text(
                          "Address : ",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          widget.address,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(FontAwesome.mobile, size: 16.0),
                        Text(
                          "Mobile : ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          widget.mob,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(MaterialIcons.email, size: 11.0),
                        Text(
                          " Email : ",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          widget.address,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(FontAwesome.birthday_cake, size: 14.0),
                        Text(
                          " DOB : ",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          widget.birthDate ?? "-",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Age : " + widget.age.toString(),
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Salary : ",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Icon(FontAwesome.rupee, size: 14.0),
                        Text(
                          widget.salary.toString(),
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }
}
