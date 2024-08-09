//statelessW
// ignore: unused_import
import 'dart:convert';
import 'dart:developer';

import 'package:app_2/config/config.dart';
import 'package:app_2/config/internal_config.dart';
import 'package:app_2/models/request/CustomersLoginPostRequest.dart';
import 'package:app_2/models/response/CustomersLoginPostResponse.dart';
import 'package:app_2/pages/register.dart';
// ignore: unused_import
import 'package:app_2/pages/showTrips.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String text = '';
  int loginTime = 0;

  String phoneNum = '0812345678';
  String passWord = '1234';

  TextEditingController phoneCtl = TextEditingController();
  TextEditingController passCtl = TextEditingController();

  String url = ''; //attibuild

  //initstate is function that start when open pages
  //init start only once,not repeat when setstate
  //init is can't work as async function 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Configuration config = Configuration();
    Configuration.getConfig().then((value){
      log(value['apiEndpoint']);
      url = value['apiEndpoint'];
    }).catchError((err){
      log(err.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onDoubleTap:(){
                log("double tap");
              },
              child: Image.asset('assets/images/logo.png')),
            const Padding(
              padding: EdgeInsets.only(left:15 ),
              child: SizedBox(
                height: 25,
                width: 200,
                child: Text('หมายเลขโทรศัพท์',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15 ,right: 15,top: 5),
              child: TextField(
                // onChanged: (value) {
                //   log(value);
                //   phoneNum = value;
                // },
                controller: phoneCtl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                border:
                OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            const Padding(
              padding: EdgeInsets.only(left:15,top: 15),
              child: SizedBox(
                height: 25,
                      width: 200,
                child: Text('รหัสผ่าน',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15 ,right: 15,bottom: 10,top: 5),
              child: TextField(
                controller: passCtl,
                obscureText: true,
                decoration: const InputDecoration(
                border:
                OutlineInputBorder(borderSide: BorderSide(width: 1)))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed:() => register(), 
                  child: const Text(
                    'ลงทะเบียนใหม่',
                    style: TextStyle(fontSize: 18),
                    )),
                FilledButton(
                  onPressed:() => login(), 
                  child: const Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
            Text(text)
          ],
        ),
      )
    );//--> backgrond
  }

  void login() async{
                  // log('this is login button');
                  // setState(() {
                  //   loginTime = loginTime + 1;
                  //   text = 'Login time:'+loginTime.toString();
                  // });

                  //log(phoneNum);

                  //Navigator.push(context, MaterialPageRoute(builder: (context) => const ShowtripsPage()));
                  // log('phone:'+phoneCtl.text);
                  // log('pass:'+passCtl.text);
                  // if(phoneCtl.text == phoneNum && passCtl.text == passWord){
                  //   log('phone number and password match');
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => const ShowtripsPage()));
                  // }else{
                  //   if(phoneCtl.text != phoneNum){
                  //     log('phone number not match');
                  //     setState(() {
                  //       text = 'phone number not match';
                  //     });
                  //   }else if(passCtl.text != passWord){
                  //     log('password not match');
                  //     setState(() {
                  //       text = 'password not match';
                  //     });
                  //   }else{
                  //     log('phonenumber and password not match');
                  //     setState(() {
                  //       text = 'phonenumber and password not match';
                  //     });
                  //   }
                  // }
                  // http.get(Uri.parse('http://192.168.103.239:3000/customers')).then(
                  //   (value){
                  //     log(value.body);
                  //   },
                  // ).catchError((eee){
                  //     log(eee.toString());
                  //   });
                  //call loging api

                  //none model
                  // var data = {
                  //               "phone":"0817399999",
                  //               "password":"1111"
                  //             };
                  
                  // user  1 p 1 , 2 , 2
                  //create obj request model


                  // var data = CustomersLoginPostRequest(phone: "0817399999",password:"1111");

                  // http.post(Uri.parse('http://192.168.103.239:3000/customers/login'),
                  // headers: {"Content-Type":"application/json; charset=utf-8"}, 
                  // // body: jsonEncode(data))

                  // //send json string of object model
                  // body: customersLoginPostRequestToJson(data))
                  // .then(
                  //   (value){
                  //     //convert json string to map<string>
                  //     // var jsonRes = jsonDecode(value.body);
                  //     // log(jsonRes['customer']['email']);
                  //     // log(jsonRes['customer']['image']);

                  //     //convert json string to obj(model)
                  //     CustomersLoginPostResponse customer = customersLoginPostResponseFromJson(value.body);
                  //     log(customer.customer.email);

                      
                  //   },
                  // ).catchError((eee){
                  //     log(eee.toString());
                  //   });



                    //try


                  var data = CustomersLoginPostRequest(phone: phoneCtl.text ,password:passCtl.text);
                  
                  http.post(Uri.parse('$API_ENDPOINT/customers/login'),
                  headers: {"Content-Type":"application/json; charset=utf-8"}, 
                  body: customersLoginPostRequestToJson(data))
                  .then(
                      (value){
                        CustomersLoginPostResponse customer = customersLoginPostResponseFromJson(value.body);
                        log(customer.customer.fullname);
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => ShowtripsPage(idx : customer.customer.idx)
                          ));
                      
                      },
                  ).catchError((eee){
                    setState(() {
                            text = 'phonenumber and password not match';
                          });
                      log(eee.toString());
                    });
                 
                }
  void register(){
                  // log('this is register button');
                  // setState(() {
                  //   text = 'อะจ๊ะเอ๋!!!';
                  // });//-----------Refresh
                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    )
                  );
                }
}