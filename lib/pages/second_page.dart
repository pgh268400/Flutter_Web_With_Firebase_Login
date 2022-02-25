import 'dart:html';
import 'package:editable/editable.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../src/web_toast_message.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final List<String> entries = <String>['Red', 'Green', 'Blue', 'Pink', 'Black'];

  void Read_Excel() async{
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['*.*'],
      dialogTitle: 'Open Excel Files',
      allowMultiple: false,
    );

    /// file might be picked
    if (pickedFile != null) {
      var bytes = pickedFile.files.single.bytes;
      var excel = Excel.decodeBytes(bytes!);
    
      
      //첫행 가져오기
      var first_table = excel.tables.keys.first;
      var first_row = excel.tables[first_table]!.rows[0];
      print('first_row');

      for (var item in first_row){
        var title = item?.value;
      }


      // for (var table in excel.tables.keys) {
      //   print(table); //sheet Name
      //   print(excel.tables[table]?.maxCols);
      //   print(excel.tables[table]?.maxRows);
      //   for (var row in excel.tables[table]!.rows) {
      //     print(row);
      //   }
      // }
    }
  }

  List<Map> rows_data = new List.empty(growable: true);
  List<Map> columns_data = new List.empty(growable: true);

  List rows = [
    {
      "name": 'James Joe',
      "date": '23/09/2020',
      "month": 'June',
      "status": 'completed'
    },
    {
      "name": 'Daniel Paul',
      "month": 'March',
      "status": 'new',
      "date": '12/4/2020',
    },
    {
      "month": 'May',
      "name": 'Mark Zuckerberg',
      "date": '09/4/1993',
      "status": 'expert'
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
  ];
  List cols = [
    {"title": '이름', 'index': 1, 'key': 'name'},
    {"title": '날짜', 'index': 2, 'key': 'date'},
    {"title": '월', 'index': 3, 'key': 'month'},
    {"title": '상태', 'index': 4, 'key': 'status'},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: Scaffold(
          backgroundColor: Color(0xFFf5f5f5),
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text("Admin Menu"),
            ),
            actions: [
              //오른쪽 아이콘 추가는 Actions로
              PopupMenuButton(
                  tooltip: "유저 정보", //기본 툴팁 설정 (이색기없으면 Show Menu 기본 메뉴 힌트뜸)
                  offset: const Offset(0, 55),
                  icon: Icon(Icons.people_alt),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: SizedBox(
                            width: 200,
                            height: 100,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 50,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('현재 로그인중\n${FirebaseAuth.instance.currentUser!.email}', style: TextStyle(fontSize: 15),)
                              ],
                            ),
                          ),
                          value: 0,
                        )
                      ]),
              Container(
                width: 100,
                child: IconButton(
                    tooltip: "로그아웃",
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      toast_message('로그아웃 했습니다.');
                    },
                    icon: Icon(Icons.logout)),
              ),
            ],
          ),
          body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Editable(
                      columns: cols,
                      rows: rows,
                      zebraStripe: true,
                      stripeColor2: (Colors.grey[200])!,
                      borderColor: Colors.blueGrey,
                      showCreateButton: true,
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    Read_Excel();
                  }, child: Text('Read Excel')),


                ],
              ),
            )

          ),
        );
  }

  Expanded myList() {
    return Expanded(
        child: Container(
          width: 100,
          height: 200,
          child: ListView.builder(
            itemCount: entries == null ? 1 : entries.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return Card(

              );
            },
          ),
        )
    );
  }
}