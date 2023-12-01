import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:idea_app/database/database_helper.dart';
import 'package:intl/intl.dart';

import '../data/idea_info.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var dbHelper = DatabaseHelper(); // database connection
  List<IdeaInfo> listIdeaInfo = []; // idea placeholder

  @override
  void initState() {
    super.initState();

    getIdeaInfo();

    // 임시 insert data

    // setInsertIdeaInfo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          "Idea App",
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: listIdeaInfo.length-1,
            itemBuilder: (context, index) {
              return listItem(index);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Image.asset(
          'assets/img/book.png',
          width: 48,
          height: 48,
        ),
        backgroundColor: Colors.amberAccent.withOpacity(0.7),
      ),
    );
  }

  Widget listItem(int index) {
    DateTime now = DateTime.now();
    index += 1;

    return Container(
      height: 82,
      margin: EdgeInsets.only(top: 16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, bottom: 16),
              child: Text(
                listIdeaInfo[index].title,
                style: TextStyle(fontSize: 20),
              )),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(bottom: 8, right: 8),
              child: Text(
                DateFormat("yyyy.MM.dd HH:mm").format(
                  DateTime.fromMicrosecondsSinceEpoch(listIdeaInfo[index].createdAt)),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              child: RatingBar.builder(
                initialRating: listIdeaInfo[index].priority.toDouble(),
                minRating: 0,
                direction: Axis.horizontal,
                itemSize: 30,
                itemPadding: EdgeInsets.symmetric(horizontal: 1),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Icon(
                    Icons.star,
                    color: Colors.amberAccent,
                  );
                },
                ignoreGestures: true,
                updateOnDrag: false,
                onRatingUpdate: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getIdeaInfo() async {
    await dbHelper.initDatabase();
    // get
    listIdeaInfo = await dbHelper.getIndeaInfo();
    // DESC
    listIdeaInfo.sort((a, b) {
      return b.createdAt.compareTo(a.createdAt);
    });
    setState(() {}); // ui update
  }

  Future<void> setInsertIdeaInfo() async {
    await dbHelper.initDatabase();
    await dbHelper.insertIdeaInfo(
      IdeaInfo(
        title: "title",
        motive: "motive",
        content: "content",
        priority: 5,
        feedback: "feedback",
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }
}
