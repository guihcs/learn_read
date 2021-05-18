

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class Store {

  static Database? _db;

  static init() async {
    if(_db != null) return;

    final dir = await getApplicationDocumentsDirectory();
    _db = await databaseFactoryIo.openDatabase('${dir.path}/learn_read.db');
  }

  static put(String key, dynamic value) async {
    await init();
    final store = StoreRef.main();
    await store.record(key).put(_db!, value);
  }

  static get(String key) async {
    await init();
    final store = StoreRef.main();
    return await store.record(key).get(_db!);
  }

}