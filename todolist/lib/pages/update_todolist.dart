import 'package:flutter/material.dart';
// http method package
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UpdatePage extends StatefulWidget {
  final v1, v2, v3;
  const UpdatePage(this.v1, this.v2, this.v3);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var _v1, _v2, _v3;
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1; //id
    _v2 = widget.v2; //title
    _v3 = widget.v3; //detail

    todo_title.text = _v2;
    todo_detail.text = _v3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไข'),
        actions: [
          IconButton(onPressed: (){
            print("delete id:$_v1");
            deleteTodo();
            Navigator.pop(context,'delete');

          }, icon: Icon(Icons.delete ,color: Colors.red[700],))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // ช่องกรอกข้อมูล title
            TextField(
              controller: todo_title,
              decoration: InputDecoration(
                  labelText: 'รายการที่ต้องทำ', border: OutlineInputBorder()),
            ),
            SizedBox(height: 30),

            // ช่องกรอกข้อมูล detail
            TextField(
              minLines: 4,
              maxLines: 5,
              controller: todo_detail,
              decoration: InputDecoration(
                  labelText: 'รายละเอียด', border: OutlineInputBorder()),
            ),
            SizedBox(height: 30),

            // button
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 0),
              child: ElevatedButton(
                onPressed: () {
                  print("------------");
                  print("title :${todo_title.text}");
                  print("detail :${todo_detail.text}");
                  updateTodo();
                  setState(() {
                    // todo_detail.clear();
                    // todo_title.clear();
                    final snackBar = SnackBar(
                      content: const Text('อัพเดตรายการเรียบร้อยแล้ว'),);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                child: Text("แก้ไข"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.green[900]), //color code 16
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(50, 20, 50, 20)), //ระยะห่างจากปุ่ม
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 30,
                    ))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future updateTodo() async {
    // var url = Uri.https('63a7-2405-9800-b520-27c3-5f8-df10-ef2d-efc9.ngrok.io','/api/post-todolist');
    var url = Uri.http('192.168.1.102:8000','/api/update-todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata ='{"title":"${todo_title.text}","detail":"${todo_detail.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print("----------");
    print(response.body);
  }

  Future deleteTodo() async{
    var url = Uri.http('192.168.1.102:8000','/api/delete-todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print("----------");
    print(response.body);

  }
}
