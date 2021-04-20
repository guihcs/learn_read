

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TextReadPage extends StatefulWidget {
  @override
  _TextReadPageState createState() => _TextReadPageState();
}

class _TextReadPageState extends State<TextReadPage> {
  @override
  Widget build(BuildContext context) {
    String text = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(),
      body: Markdown(
        styleSheet: MarkdownStyleSheet(p: TextStyle(fontSize: 18)),
        data: text
        ),
    );
  }
}