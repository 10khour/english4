import 'package:audioplayers/audioplayers.dart';
import 'package:english4k/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styled_text/styled_text.dart';

// ignore: must_be_immutable
class WordWidget extends StatefulWidget {
  List<Word>? words;
  WordWidget({super.key, this.words});
  @override
  State<StatefulWidget> createState() {
    return _WordState();
  }
}

class _WordState extends State<WordWidget> {
  final player = AudioPlayer();
  FocusNode focusNode = FocusNode();
  Widget body = const Center(
      child: Text(
    "Loading ...",
    style: TextStyle(fontSize: 40),
  ));
  int state = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    player.stop();
    if (widget.words != null && index < widget.words!.length && index >= 0) {
      player.play(UrlSource(
          "$host/assets/${widget.words?[index].index}/${widget.words?[index].sound}"));
      body = Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(children: [
                Text(
                  widget.words![index].en,
                  style: const TextStyle(
                      fontSize: 60, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  widget.words![index].pron,
                  style: const TextStyle(fontSize: 45),
                ),
              ]),
              const Spacer(),
              Container(
                  width: 300,
                  height: 300,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          150) // Adjust the radius as needed
                      ),
                  child: Image.network(
                      height: 250,
                      "$host/assets/${widget.words?[index].index}/${widget.words?[index].image}")),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            widget.words![index].desc,
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(
            height: 60,
          ),
          toRichText(widget.words![index].exam)
        ]),
      );
    } else {
      body = const Center(
          child: Text(
        "End",
        style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
      ));
    }

    return RawKeyboardListener(
      autofocus: true,
      focusNode: focusNode,
      onKey: (event) {
        if (event is RawKeyDownEvent) {
          // just keyDown
          String key = event.logicalKey.keyLabel;
          print("===$key");
          if (key == 'Escape' || key == 'Go Back') {
            player.pause();

            Navigator.pop(context);
          }
          if (key == 'Arrow Up') {
            player.pause();
            setState(() {
              index--;
            });
          }
          if (key == 'Arrow Down') {
            player.pause().then(
              (value) {
                setState(() {
                  index++;
                });
              },
            );
          }
          if (key == ' ') {
            player.pause().then((v) {
              setState(() {
                index++;
              });
            });
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(37, 137, 189, 0.6),
        body: body,
      ),
    );
  }

  Widget toRichText(String exam) {
    return StyledText(
      style: const TextStyle(fontSize: 40),
      text: exam,
      tags: {
        'strong':
            StyledTextTag(style: const TextStyle(fontWeight: FontWeight.bold)),
      },
    );
  }
}

class Word {
  String en;
  String pron;
  String desc;
  String exam;
  String vi;
  String image;
  String sound;
  int index;
  Word(
      {required this.en,
      required this.pron,
      required this.desc,
      required this.exam,
      required this.vi,
      required this.image,
      required this.index,
      required this.sound});

  factory Word.jfromJson(int index, Map<String, dynamic> json) {
    return Word(
        en: json['en'],
        pron: json['pron'],
        desc: json['desc'],
        exam: json['exam'],
        vi: json['vi'],
        image: json['image'],
        index: index,
        sound: json['sound']);
  }
}
