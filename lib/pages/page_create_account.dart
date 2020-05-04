import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}

class CreateAccountPageState extends State<CreateAccountPage> {
  final formKey = GlobalKey<FormState>();
  String _email, _password, _userName;
  bool _isObscure = true;
  Color _eyeColor;

  Future<bool> Success() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('你已成功注册账号'),
            content: new Text('请用账号密码登陆'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'LogIn'),
                child: new Text('确定'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<bool> Faliure() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('出错。'),
            content: new Text('请稍后再试'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'LogIn'),
                child: new Text('确定'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<Null> CreateAccount() async {
    print('begin async');
    Response response;
    try {
      var data = {'mail': _email, 'password': _password, 'nick': _userName};
      response = await post(
        "http://47.107.117.59/fff/register.php",
        body: data,
      );
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        Success();
        print('请求成功');
      }
    } on Error catch (e) {
      Faliure();
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
        body: Builder(
          builder: (BuildContext context) {
            return Form(
                key: formKey,
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
                    buildTextFormField(),
                    SizedBox(height: 30.0),
                    buildPasswordTextField(context),
                    SizedBox(height: 60.0),
                    buildLoginButton(context),
                    SizedBox(height: 30.0),
                  ],
                ));
          }
        ));
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '昵称',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入昵称';
        }
      },
      onChanged: (text) {
        _userName = text;
        print('username:$_userName');
      },
      maxLength: 30,
    );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 170.0,
        child: FlatButton(
            child: Text(
              '注册',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            onPressed: () {
              if (!formKey.currentState.validate()) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('输入内容出错')));
              } else {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('正在请求')));
                CreateAccount();
              }
            }),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onChanged: (text) {
        _password = text;
        print('password:$_password');
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
        print('email:$_email');
      },
      //onSaved: (String value) => _email = value,
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Create Account',
        textScaleFactor: 1.5,
        style: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
      ),
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
}
