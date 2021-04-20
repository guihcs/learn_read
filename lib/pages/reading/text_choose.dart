

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextChoosePage extends StatefulWidget {
  @override
  _TextChoosePageState createState() => _TextChoosePageState();
}

class _TextChoosePageState extends State<TextChoosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Read'),
      ),
      body: Column(children: [
        _bookTile('assets/text/alice.md', 'Alice'),
        _bookTile('assets/text/pinocchio.md', 'Pinocchio'),
      ],),
    );
  }

  _bookTile(textPath, name){
    return Card(child: 
        ListTile(
          onTap: () async {
            String text = await rootBundle.loadString(textPath, cache: false);
            Navigator.of(context).pushNamed('textRead', arguments: text);
          },
          title: 
        Text(name),),);
  }
}