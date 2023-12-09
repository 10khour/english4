import 'package:english4k/components/word.dart';
import 'package:flutter/material.dart';

class UnitWdiget extends StatefulWidget {
  Unit unit;
  UnitWdiget({super.key, required this.unit});
  @override
  State<StatefulWidget> createState() {
    return _UnitWdiget();
  }
}

class _UnitWdiget extends State<UnitWdiget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextButton(
        child: Text("${widget.unit.en}"),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: () {
            return WordWidget();
          }));
        },
      ),
      trailing: Spacer(),
    );
  }
}

class Unit {
  int index;
  String image;
  String en;
  List<Word> worldlist;
  Unit(
      {required this.image,
      required this.index,
      required this.en,
      required,
      required this.worldlist});

  factory Unit.fromJson(int index, Map<String, dynamic> json) {
    return Unit(
        image: json['image'], en: json['en'], worldlist: [], index: index);
  }
}
