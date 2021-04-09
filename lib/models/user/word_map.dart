

class WordMap {
  late Map<String, Set<String>> _wordMap;

  WordMap.fromJson(Map<String, dynamic> json){
    _wordMap = json.map((key, value) => MapEntry(key, Set.from(value)));
  }

  toJson(){
    final json = {};

    return json;
  }

  Set<String> getSet(word){
    return _wordMap[word]!;
  }
}