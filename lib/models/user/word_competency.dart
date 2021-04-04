class Competencies {
  double total = 0;
  Competencies(this.total);

  Competencies.fromJson(json){
    total = json['total'];
  }
  
  toJson(){
    final json = {};
    json['total'] = total;
    return json;
  }

  @override
  String toString() {
    return '{total: $total}';
  }
}