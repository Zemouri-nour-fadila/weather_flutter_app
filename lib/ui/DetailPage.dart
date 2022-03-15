import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
  }

  final List<int> _items = List<int>.generate(50, (int index) => index);

  //This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 248, 248, 255),
          foregroundColor: Colors.black,
          elevation: 0,
          title: const Text(
            "Location",
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color.fromARGB(255, 248, 248, 255),
              child: IconButton(
                  color: Colors.black,
                  onPressed: () {},
                  icon: const Icon(
                    IconData(0xe047, fontFamily: 'MaterialIcons'),
                    size: 25,
                  )),
            ),
          ],
        ),
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          for (int index = 0; index < _items.length; index += 1)
            Card(
              key: Key('$index'),
              elevation: 10,
              //tileColor: _items[index].isOdd? Color(Colors.blue): Color(Colors.lightBlue),
              color: const Color.fromARGB(255, 248, 248, 255),
              child: Text('Item ${_items[index]}'),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final int item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);
          });
        },
      ),
    );
  }
}
