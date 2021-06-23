

class WordMap {
  late Map<String, Set<String>> _wordMap;

  WordMap.fromJson(Map<String, dynamic> json){
    _wordMap = json.map((key, value) => MapEntry(key, Set.from(value)));
  }

  toJson(){
    return _wordMap.map((key, value) => MapEntry(key, List.from(value)));
  }

  Set<String>? getWordSet(word){
    return _wordMap[word];
  }
}