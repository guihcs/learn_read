


import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:learn_read/models/user/word_competency.dart';
import 'package:learn_read/models/user/word_map.dart';

class UserProgressService {
  static late WordMap _wordMap;
  static late Map<String, Competencies> _wordCompetencies;

  static init() async {
    String wordMapData = await rootBundle.loadString('assets/text/word_map.json', cache: false);
    Map<String, dynamic> wordData = jsonDecode(wordMapData);
    _wordMap = WordMap.fromJson(wordData['letterWordMap']);
    _wordCompetencies = Map<String, Competencies>.from(wordData['wordList'].map((key, value) => MapEntry(key, Competencies.fromJson(value))));
  }

  static WordMap get wordMap => _wordMap;
  static Map<String, Competencies> get wordCompetencies => _wordCompetencies;
}