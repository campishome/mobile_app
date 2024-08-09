
import 'dart:developer';
import 'package:app_2/models/request/CustomersRegisterPostRequest.dart';
import 'package:app_2/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:app_2/config/config.dart';

import 'package:http/http.dart' as http;
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController nameCtrl = TextEditingController();
TextEditingController phoneCtrl = TextEditingController();
TextEditingController emailCtrl = TextEditingController();
TextEditingController passCtrl = TextEditingController();
TextEditingController passwordCtrl = TextEditingController();

String url = ''; //attibuild


class _RegisterPageState extends State<RegisterPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Configuration config = Configuration();
    Configuration.getConfig()
    .then((value){
      log(value['apiEndpoint']);
      url = value['apiEndpoint'];
    }).catchError((err){
      log(err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ลงทะเบียนสมาชิกใหม่'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(left:20 ),
              child: SizedBox(
                height: 25,
                width: 200,
                child: Text('ชื่อนาม-สกุล',style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
            ),
             Padding(
                padding: const EdgeInsets.only(left:20 ,right: 20,top: 0 ,bottom: 15),
                child: TextField(
                  controller: nameCtrl,
                  //obscureText: true,
                  decoration: const InputDecoration(
                  border:
                  OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            //-------
            const Padding(padding: EdgeInsets.only(left:20 ),
              child: SizedBox(
                height: 25,
                width: 200,
                child: Text('หมายเลขโทรศัพท์',style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
            ),
             Padding(
                padding: const EdgeInsets.only(left:20 ,right: 20,top: 0,bottom: 15),
                child: TextField(
                  controller: phoneCtrl,
                  //obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                  border:
                  OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            //-------
            const Padding(padding: EdgeInsets.only(left:20 ),
              child: SizedBox(
                height: 25,
                width: 200,
                child: Text('อีเมล',style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
            ),
             Padding(
                padding: const EdgeInsets.only(left:20 ,right: 20,top: 0,bottom: 15),
                child: TextField(
                  controller: emailCtrl,
                  //obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                  border:
                  OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            //-------
            const Padding(padding: EdgeInsets.only(left:20 ),
              child: SizedBox(
                height: 25,
                width: 200,
                child: Text('รหัสผ่าน',style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left:20 ,right: 20,top: 0,bottom: 15),
                child: TextField(
                  controller: passCtrl,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                  border:
                  OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            //-------
            const Padding(padding: EdgeInsets.only(left:20 ),
              child: SizedBox(
                height: 25,
                width: 200,
                child: Text('ยืนยันรหัสผ่าน',style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left:20 ,right: 20,top: 0,bottom: 15),
                child: TextField(
                  controller: passwordCtrl,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                  border:
                  OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton(
                    onPressed: () => registerButton(), 
                    child: const Text(
                      'สมัครสมาชิก',
                      style: TextStyle(fontSize: 15)
                    )
                  )
                ],
            ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                      'หากมีบัญชีอยู่แล้ว?',
                      style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                    onPressed:() => registerButton2(), 
                    child: const Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(fontSize: 15),
                    )
                  )
                ],
          )
          ],
        ),
      ),
    );
  }

  void registerButton() {
    if(passCtrl.text == passwordCtrl.text){
      log('match');
       var data = CustomersRegisterPostRequest(fullname: nameCtrl.text, phone: phoneCtrl.text, email: emailCtrl.text, 
    image: "$url/contents/4a00cead-afb3-45db-a37a-c8bebe08fe0d.png", password: passwordCtrl.text);

              http.post(Uri.parse('$url/customers'),
                  headers: {"Content-Type":"application/json; charset=utf-8"}, 
                  body: customersRegisterPostRequestToJson(data))
                  .then(
                      (value){
                        log('success');
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => LoginPage()
                          ));
                      },
                  ).catchError((eee){
                      log("insert error"+eee.toString());
                    });
    }else{
      setState((){
        log('not match');
      });
    }
  }
  void registerButton2(){

  }
}