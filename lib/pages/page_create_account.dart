import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';



class CreateAccountPage extends StatefulWidget {
  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}

class CreateAccountPageState extends State<CreateAccountPage> {
  final formKey = GlobalKey<FormState>();
  String _email, _password, _userName;
  bool _isObscure = true;
  Color _eyeColor;
  final uuid = Uuid().v1(); 

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

  Future<bool> Failure() async {
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
      var data = {'uuid':uuid ,'mail': _email, 'password': _password, 'nick': _userName};
      response = await post(
        "http://47.107.117.59/fff/register.php",
        body: data,
      );
      Map<String, dynamic> mapFromJson = json.decode(response.body.toString());
      print(response.body.toString());
      if (mapFromJson['status'] == 10000) {
        Success();
        print('请求成功');
      }
    } on Error catch (e) {
      Failure();
    }
    return;
  }
//把scaffold分离防止FlutterError (Scaffold.of() called with a context that does not contain a Scaffold.
// No Scaffold ancestor could be found starting from the context that was passed to Scaffold.of(). This usually happens when the context provided is from the same StatefulWidget as that whose build function actually creates the Scaffold widget being sought.
// There are several ways to avoid this problem. The simplest is to use a Builder to get a context that is "under" the Scaffold. For an example of this, please see the documentation for Scaffold.of():
//   https://api.flutter.dev/flutter/material/Scaffold/of.html
// A more efficient solution is to split your build function into several widgets. This introduces a new context from which you can obtain the Scaffold. In this solution, you would have an outer widget that creates the Scaffold populated by instances of your new inner widgets, and then in these inner widgets you would use Scaffold.of().
// A less elegant but more expedient solution is assign a GlobalKey to the Scaffold, then use the key.currentState property to obtain the ScaffoldState rather than using the Scaffold.of() function.
// The context used was:
//   LoginPage)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Builder(builder: (BuildContext context) {
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
                  Text('密码：千万不要输入其他网站使用过的密码，此应用程式没有使用加密传输，推荐在此使用“password”'),
                  SizedBox(height: 60.0),
                  buildLoginButton(context),
                  SizedBox(height: 30.0),
                ],
              ));
        }));
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
          labelText: '密码：千万不要输入其他网站使用过的密码，此应用程式没有使用加密传输，推荐在此使用“password”',
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
