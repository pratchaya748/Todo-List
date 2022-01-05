import 'package:flutter/material.dart';
// http method package
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AddPage extends StatefulWidget { 
  const AddPage({ Key? key }) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มรายการใหม่'),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // ช่องกรอกข้อมูล title
            TextField(
                  controller: todo_title,
                  decoration: InputDecoration(
                      labelText: 'รายการที่ต้องทำ', 
                      border: OutlineInputBorder()),
                ),
            SizedBox(height:30),
            
            // ช่องกรอกข้อมูล detail
            TextField(
              minLines: 4,
              maxLines: 5,
                  controller: todo_detail,
                  decoration: InputDecoration(
                      labelText: 'รายละเอียด', 
                      border: OutlineInputBorder()),
                ),
            SizedBox(height:30),

            // button
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,0,30,0),
                child: ElevatedButton(
                  onPressed: () {
                    print("------------");
                    print("title :${todo_title.text}");
                    print("detail :${todo_detail.text}");
                    postTodo();
                    setState(() {
                      todo_detail.clear();
                      todo_title.clear();
                    });
                  },
                  child: Text("เพิ่มรายการ") , 
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green[900]) ,//color code 16 
                    padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 20, 50, 20)),//ระยะห่างจากปุ่ม
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30,))),),
              ),
            
          ],
        ),
      ),
      
    );
  }


  Future postTodo() async{
    // var url = Uri.https('63a7-2405-9800-b520-27c3-5f8-df10-ef2d-efc9.ngrok.io','/api/post-todolist');
    var url = Uri.http('192.168.1.102:8000','/api/post-todolist');
    Map<String, String> header = {"Content-type":"application/json"};
    String jsondata = '{"title":"${todo_title.text}","detail":"${todo_detail.text}"}';
    var response = await http.post(url ,headers: header ,body: jsondata);
    print("----------");
    print(response.body);
  }


}