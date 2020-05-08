import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password, uuid;
  bool _isObscure = true;
  Color _eyeColor;

  Future<bool> Faliure() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('密码不正确'),
            content: new Text('请重试'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('确定'),
              ),
            ],
          ),
        )) ??
        false;
  }

//用shared_preference存储uuid
  addUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uuid', "$uuid");
  }

//登陆操作
  Future<Null> LogIn() async {
    print('开始登陆');
    Response response;
    try {
      var data = {'mail': _email, 'password': _password};
      response = await post(
        "http://47.107.117.59/fff/login.php",
        body: data,
      );
      Map<String, dynamic> mapFromJson = json.decode(response.body);
      if (mapFromJson['status'] == 10000) {
        uuid = mapFromJson['uuid'];
        print('请求成功');
        addUuid();
        Navigator.popAndPushNamed(context, 'Navigator');
      } else if (mapFromJson['status'] == 20000) {
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("登陆失败"),
          action: new SnackBarAction(
            label: "OK",
            onPressed: () {},
          ),
        ));
      }
    } on Error catch (e) {
      Faliure();
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(
      builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            children: <Widget>[
              SizedBox(
                height: kToolbarHeight,
              ),
              buildTitle(),
              buildTitleLine(),
              SizedBox(height: 70.0),
              buildEmailTextField(),
              SizedBox(height: 30.0),
              buildPasswordTextField(context),
              SizedBox(height: 60.0),
              buildLoginButton(context),
              SizedBox(height: 30.0),
              buildRegisterText(context),
            ],
          ),
        );
      },
    ));
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('没有账号？'),
            GestureDetector(
              child: Text(
                '点击注册',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                print('去注册');
                Navigator.pushNamed(context, 'Register');
              },
            ),
          ],
        ),
      ),
    );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 170.0,
        child: FlatButton(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  '登陆',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            onPressed: () {
              if (!_formKey.currentState.validate()) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('输入内容出错')));
              } else {
                LogIn();
              }
            }),
      ),
    );
  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'ChangePassword');
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onChanged: (text) {
        _password = text;
      },
      //onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
          labelText: '密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '邮箱',
      ),
      //validator: (val)=> (val == null || val.isEmpty) ? "请输入商品名称": null,
      validator: (String value) {
        var emailReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        if (!emailReg.hasMatch(value)) {
          print('正则不通过');
          return '请输入正确的邮箱地址';
        }
      },
      onChanged: (text) {
        _email = text;
      },
      //onSaved: (String value) => _email = value,
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Theme.of(context).accentColor,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Log In',
        textScaleFactor: 1.5,
        style: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
