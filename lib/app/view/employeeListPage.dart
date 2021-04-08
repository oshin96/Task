import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'dart:convert';
import 'detailsPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  double _offsetContainer;
  var _text;
  var _oldtext;
  var _heightscroller;
  var _itemsizeheight = 75.0; //NOTE: size items
  var _marginRight = 50.0;
  var _sizeheightcontainer;
  var posSelected = 0;
  var diff = 0.0;
  var height = 0.0;
  var txtSliderPos = 0.0;
  ScrollController _controller;
  String message = "";
  var empList = [];
  var data = [];
  bool isLoading = false;

  int currentLength = 0;

  int selectedIndex;

  List _alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  @override
  void initState() {
    getJsonData();
    Future.delayed(Duration(seconds: 3), () {
      _offsetContainer = 0.0;
      _controller = ScrollController();
      _controller.addListener(_scrollListener);
      //sort the item list
      setState(() {
        data.sort((a, b) {
          return a["firstName"].toString().compareTo(b["firstName"].toString());
        });
      });
    });

    super.initState();
  }

  getJsonData() async {
    try {
      var res = await DefaultAssetBundle.of(context)
          .loadString("assets/employees.json");
      empList = json.decode(res);

      setState(() {
        data = empList;
      });
    } catch (e) {
      print(e);
    }
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      if ((_offsetContainer + details.delta.dy) >= 0 &&
          (_offsetContainer + details.delta.dy) <=
              (_sizeheightcontainer - _heightscroller)) {
        _offsetContainer += details.delta.dy;
        posSelected =
            ((_offsetContainer / _heightscroller) % _alphabet.length).round();
        _text = _alphabet[posSelected];
        if (_text != _oldtext) {
          for (var i = 0; i < data.length; i++) {
            if (_text.toString().compareTo(
                    data[i]["firstName"].toString().toUpperCase()[0]) ==
                0) {
              _controller.jumpTo(i * _itemsizeheight);
              break;
            }
          }
          _oldtext = _text;
        }
      }
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {
    _offsetContainer = details.globalPosition.dy - diff;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appbarWidget(),
      body: LayoutBuilder(
        builder: (context, contrainsts) {
          diff = height - contrainsts.biggest.height;
          _heightscroller = (contrainsts.biggest.height) / _alphabet.length;
          _sizeheightcontainer = (contrainsts.biggest.height); //NO
          return listData();
        },
      ),
    );
  }

  Widget listData() {
    return Stack(children: [
      data.length != null
          ? ListView.builder(
              itemCount: data.length,
              controller: _controller,
              itemExtent: _itemsizeheight,
              itemBuilder: (context, position) {
                return onItemTap(context, position);
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      Positioned(
        right: _marginRight,
        top: _offsetContainer,
        child: _getSpeechBubble(),
      ),
      alignAlphabateList(),
    ]);
  }

  Widget alignAlphabateList() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragStart: _onVerticalDragStart,
        child: Container(
          ///  height: 20.0 * 26,
          color: Colors.transparent,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: []..addAll(
                new List.generate(
                    _alphabet.length, (index) => _getAlphabetItem(index)),
              ),
          ),
        ),
      ),
    );
  }

  Widget onItemTap(BuildContext context, int position) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                    name: data[position]["firstName"],
                    lastname: data[position]["lastName"],
                    email: data[position]["email"],
                    age: data[position]["age"].toString(),
                    mob: data[position]["contactNumber"],
                    image: data[position]["imageUrl"],
                    salary: data[position]["salary"].toString(),
                    address: data[position]["address"],
                    birthDate: data[position]["dob"])));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: itemCard(position),
        ),
      ),
    );
  }

  Widget appbarWidget() {
    return AppBar(
      toolbarHeight: 100.0,
      elevation: 0.0,
      backgroundColor: Colors.black,
      title: Text(
        "EMPLOYEE LIST",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26.0),
      ),
      centerTitle: true,
    );
  }

  Widget itemCard(int position) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FadeInImage.assetNetwork(
          image: data[position]["imageUrl"],
          placeholder: "assets/giphy.gif",
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            data[position]["firstName"],
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        Text(
          data[position]["lastName"],
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }

  _getSpeechBubble() {
    return new SpeechBubble(
      nipLocation: NipLocation.RIGHT,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 30,
            child: Center(
              child: Text(
                "${_text ?? "${_alphabet.first}"}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getAlphabetItem(int index) {
    return new Expanded(
      child: new Container(
        width: 40,
        height: 20,
        alignment: Alignment.center,
        child: new Text(
          _alphabet[index],
          style: (index == posSelected)
              ? new TextStyle(fontSize: 16, fontWeight: FontWeight.w700)
              : new TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  _scrollListener() {
    if ((_controller.offset) >= (_controller.position.maxScrollExtent)) {
      print("reached bottom");
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print("reached top");
    }
  }
}
