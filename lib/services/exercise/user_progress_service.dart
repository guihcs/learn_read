import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:learn_read/models/user/word_competency.dart';
import 'package:learn_read/models/user/word_map.dart';
import 'package:learn_read/services/database/store.dart';

class UserProgressService {
  static late WordMap _wordMap;
  static late Map<String, Competencies> _wordCompetencies;
  static List<num> _progressHistory = [0.0];
  static num _currentProgress = 0;
  static double _learningRate = 0.1;

  static init() async {
    if (!await _loadProgress()) _initState();
  }

  static _initState() async {
    String wordMapData = await rootBundle.loadString('assets/text/word_map.json', cache: false);
    Map<String, dynamic> wordData = jsonDecode(wordMapData);
    _wordMap = WordMap.fromJson(wordData['letterWordMap']);
    _wordCompetencies = Map<String, Competencies>.from(
        wordData['wordList'].map((key, value) => MapEntry(key, Competencies.fromJson(value))));
  }

  static saveProgress() async {
    await Store.put('wordMap', _wordMap.toJson());
    await Store.put('competencies', _wordCompetencies.map((key, value) => MapEntry(key, value.toJson())));
    await Store.put('progressHistory', _progressHistory);
    await Store.put('currentProgress', _currentProgress);
    await Store.put('learningRate', learningRate);
  }

  static _loadProgress() async {
    dynamic wm = await Store.get('wordMap');
    if (wm == null || wm.isEmpty) return false;
    dynamic competencies = await Store.get('competencies');
    _wordMap = WordMap.fromJson(wm);
    _wordCompetencies = Map<String, Competencies>.from(
        competencies.map((key, value) => MapEntry(key, Competencies.fromJson(value))));
    _progressHistory = List.from(await Store.get('progressHistory'));
    _currentProgress = await Store.get('currentProgress');
    _learningRate = await Store.get('learningRate');
    return true;
  }

  static WordMap get wordMap => _wordMap;

  static Map<String, Competencies> get wordCompetencies => _wordCompetencies;

  static get currentProgress => _currentProgress;

  static set currentProgress(value) {
    _progressHistory.add(_currentProgress);
    _currentProgress = value >= 0 ? value : 0;
  }

  static get progressHistory => _progressHistory;

  static double get learningRate => _learningRate;

  static set learningRate(value) {
    _learningRate = value;
    if (_learningRate < 0.1)
      _learningRate = 0.1;
    else if (_learningRate > 1) _learningRate = 1;
  }
}
