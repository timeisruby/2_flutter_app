import 'package:idea_app/data/idea_info.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database database;

  // init
  Future<void> initDatabase() async {
    String path = join(await getDatabasesPath(), "idea_app.db");

    // database open or create
    database = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
      CREATE TABLE IF NOT EXISTS tb_idea (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        motive TEXT,
        content TEXT,
        priority INTEGER,
        feedback TEXT,
        createdAt INTEGER) ''');
    });
  }
// insert
  Future<void> insertIdeaInfo(IdeaInfo idea) async {
    try{
      await database.insert('tb_idea', idea.toMap());
    }catch (e){
      print("insert tb_idea has failed : $e");
    }
  }

  // Future<void> insertIdeaInfo(IdeaInfo idea) async{
  //   await database.insert('tb_idea', idea.toMap());
  // }

  // 레코드 값 반환
  // Future<int> insertIdeaInfo(IdeaInfo idea) async {
  //   return await database.insert('tb_idea', idea.toMap());
  // }


// select
  Future<List<IdeaInfo>> getIndeaInfo() async{
    final List<Map<String,dynamic>> result = await database.query('tb_idea');
    return List.generate(result.length, (index){
      return IdeaInfo.fromMap(result[index],);
    },);
  }

// update
  Future<int> updateIdeaInfo(IdeaInfo idea)async{
    return await database.update('tb_idea', idea.toMap(),
    where: 'id=?',
    whereArgs: [idea.id]);
  }

// delete
  Future<int> deleteIdeaInfo(int id) async {
    return await database.delete('tb_idea',
    where: 'id=?',
    whereArgs: [id]);
  }

  // database close
  Future<void> closeDatabase() async{
    await database.close();
  }
}

