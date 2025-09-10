import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_first_app/config/config.dart';
import 'package:my_first_app/model/request/response/customer_login_post_req.dart';
import 'package:my_first_app/model/request/response/customer_login_post_res.dart';
import 'package:my_first_app/pages/register.dart';
import 'package:my_first_app/pages/showtrip.dart';
import 'package:http/http.dart' as http;

class LOginPage extends StatefulWidget {
  LOginPage({super.key, required String title});

  @override
  State<LOginPage> createState() => _LOginPageState();
}

class _LOginPageState extends State<LOginPage> {
  String text = '';
  int num = 0;
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  String url = "";

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('loginPage')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(child: Image.asset('assets/images/1234.png')),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 0, 0),
                child: Text(
                  'หมายเลขโทรศัพ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: TextField(
                  controller: phoneCtl,
                  // onChanged: (value) {
                  //   phone = value;
                  //   log(value);
                  // },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 0, 0),
                child: Text(
                  'รหัสผ่าน',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: TextField(
                  controller: passwordCtl,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: TextButton(
                      onPressed: register,
                      child: const Text('ลงทะเบียนใหม่'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: FilledButton(
                      onPressed: login,
                      child: const Text('เข้าสู่ระบบ'),
                    ),
                  ),
                ],
              ),
              Center(child: Text(text, style: TextStyle(fontSize: 20))),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const registerpage()),
    );
  }

  void login() {
    CustomerLoginPostRequest req = CustomerLoginPostRequest(
      phone: phoneCtl.text,
      password: passwordCtl.text,
    );
    http
        .post(
          Uri.parse("$url/customers/login"),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: customerLoginPostRequestToJson(req),
        )
        .then((value) {
          log(value.body);
          CustomerLoginPostResponse customerLoginPostResponse =
              customerLoginPostResponseFromJson(value.body);
          log(customerLoginPostResponse.customer.fullname);
          log(customerLoginPostResponse.customer.email);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ShowtripPage(cid: customerLoginPostResponse.customer.idx),
            ),
          );
        })
        .catchError((error) {
          log('Error $error');
        });
  }
}
