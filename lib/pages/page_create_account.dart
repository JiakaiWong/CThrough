import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}

class CreateAccountPageState extends State<CreateAccountPage> {
  final formKey = GlobalKey<FormState>();
  bool mailUsable = false;

  bool MailSenderTimer = false;
  String _email, _password, _userName, _verificationCode, verificationEmailCode;
  bool _isObscure = true;
  Color _eyeColor;
  final uuid = Uuid().v1();

  startMailSenderTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('MailSenderTimer', true);
    var _duration = new Duration(seconds: 60);
    return new Timer(_duration, changeMailSenderTimer);
  }

  changeMailSenderTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('MailSenderTimer', false);
  }

  Future<bool> gettMailSenderTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MailSenderTimer = prefs.getBool('MailSenderTimer');
    return MailSenderTimer;
  }

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
      var data = {
        'uuid': uuid,
        'mail': _email,
        'password': _password,
        'nick': _userName,
        'verificationCode': _verificationCode,
      };
      response = await post(
        "http://47.107.117.59/fff/registerPlus.php",
        body: data,
      );
      Map<String, dynamic> mapFromJson = json.decode(response.body.toString());
      print(response.body.toString());
      if (mapFromJson['status'] == 10000) {
        verificationEmailCode = mapFromJson['no'];
        Success();
        print('请求成功');
      }
    } on Error catch (e) {
      Failure();
    }
    return;
  }

  Future<bool> VerificationSent() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('已发送验证码'),
            content: new Text('邮件编号：$verificationEmailCode'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.pop(context),
                child: new Text('确定'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<bool> VerifyTooOften() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('验证码发送太频繁'),
            content: new Text('请在前一次请求后60秒再试'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.pop(context),
                child: new Text('确定'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<bool> WrongVerificationCode() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('验证码错误'),
            content: new Text('请再次检查邮件'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.pop(context),
                child: new Text('确定'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<bool> EmailUnusable() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('邮箱已被占用'),
            content: new Text('请尝试更换'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.pop(context),
                child: new Text('确定'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<Null> SendVerificationCode() async {
    print('开始发验证码');
    Response response;
    try {
      var data = {
        'mail': _email,
      };
      response = await post(
        "http://47.107.117.59/fff/sendMail.php",
        body: data,
      );
      Map<String, dynamic> mapFromJson = json.decode(response.body.toString());
      print(response.body.toString());
      if (mapFromJson['status'] == 10000) {
        VerificationSent();
        print('验证码请求成功');
      }
    } on Error catch (e) {
      Failure();
    }
    return;
  }

  Future<bool> checkEmail() async {
    print('开始检查邮件可用性');
    Response response;
    try {
      var data = {
        'mail': _email,
      };
      response = await post(
        "http://47.107.117.59/fff/checkValid.php",
        body: data,
      );
      Map<String, dynamic> mapFromJson = json.decode(response.body.toString());
      print(response.body.toString());
      if (mapFromJson['status'] == 10000) {
        VerificationSent();
        print('验证码请求成功');
        return true;
      } else if (mapFromJson['status'] == 20000) {
        //EmailUnusable();//在下面异步用返回值弹出消息
        return false;
      }
    } on Error catch (e) {
      Failure();
    }
    return false;
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
    changeMailSenderTimer();
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
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 3, child: buildVerificationCodeTextField()),
                      Expanded(
                        flex: 3,
                        child: FlatButton(
                          onPressed: () {
                            gettMailSenderTimer().then((response) {
                              if (response == true) {
                                VerifyTooOften();
                              } else {
                                checkEmail().then((response) {
                                  if (response == true) {
                                    SendVerificationCode();
                                    startMailSenderTimer();
                                  } else {
                                    EmailUnusable();
                                  }
                                });
                              }
                            });
                          },
                          child: Container(
                            height: 35.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: Text(
                                '发送验证码',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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
            child: Container(
              height: 45.0,
              width: 170.0,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  '注册',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
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

  TextFormField buildVerificationCodeTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '验证码',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入验证码';
        }
      },
      onChanged: (text) {
        _verificationCode = text;
        print('verificationcode:$_verificationCode');
      },
      maxLength: 4,
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
