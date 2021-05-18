

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TextReadPage extends StatefulWidget {
  @override
  _TextReadPageState createState() => _TextReadPageState();
}

class _TextReadPageState extends State<TextReadPage> {

  dynamic _args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _args = ModalRoute.of(context)?.settings.arguments;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(_args?['title'] ?? 'No title'),
      ),
      body: Markdown(
        styleSheet: MarkdownStyleSheet(p: TextStyle(fontSize: 18)),
        data: _args?['text'] ?? 'No text'
        ),
    );
  }
}