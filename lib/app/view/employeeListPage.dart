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

  int increment = 5;

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

      print(data);
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

      print("=============");
    } catch (e) {}
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
//    var heightAfterToolbar = height - diff;
//    print("height1 $heightAfterToolbar");
//    var remavingHeight = heightAfterToolbar - (20.0 * 26);
//    print("height2 $remavingHeight");
//
//    var reducedheight = remavingHeight / 2;
//    print("height3 $reducedheight");
    _offsetContainer = details.globalPosition.dy - diff;
  }

  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });

    // Add in an artificial delay
    await Future.delayed(const Duration(seconds: 2));

    for (var i = currentLength; i <= currentLength + increment; i++) {
      data.add(data[i]);
    }
    setState(() {
      isLoading = false;
      currentLength = data.length;
    });

    print(data[0]["age"]);

    print("++++++++++++++++++++++++++++++++++++++++");
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: Text("EMPLOYEE LIST",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 26.0)),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, contrainsts) {
          diff = height - contrainsts.biggest.height;
          _heightscroller = (contrainsts.biggest.height) / _alphabet.length;
          _sizeheightcontainer = (contrainsts.biggest.height); //NO
          return new Stack(children: [
            data.length != null
                ? ListView.builder(
                    itemCount: data.length,
                    controller: _controller,
                    itemExtent: _itemsizeheight,
                    itemBuilder: (context, position) {
                      if (isLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                            strokeWidth: 0.6,
                          ),
                        );
                      }
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                            name: data[position]["firstName"],
                                            lastname: data[position]
                                                ["lastName"],
                                            email: data[position]["email"],
                                            age: data[position]["age"]
                                                .toString(),
                                            mob: data[position]
                                                ["contactNumber"],
                                            image: data[position]["imageUrl"],
                                            salary: data[position]["salary"]
                                                .toString(),
                                            address: data[position]["address"],
                                          )));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FadeInImage.assetNetwork(
                                  image: data[position]["imageUrl"],
                                  placeholder: "assets/giphy.gif",
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
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
                            ),
                          ),
                        ),
                      );
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
            Align(
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
                        new List.generate(_alphabet.length,
                            (index) => _getAlphabetItem(index)),
                      ),
                  ),
                ),
              ),
            ),
          ]);
        },
      ),
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

  ValueGetter callback(int value) {}

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

  //scroll detector for reached top or bottom
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
