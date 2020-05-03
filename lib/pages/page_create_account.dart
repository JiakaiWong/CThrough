import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}

class CreateAccountPageState extends State<CreateAccountPage> {
  String password;
  String mail;
  String userName;
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
    Response response;
    try {
      var data = {'mail': mail, 'password': password, 'nick': userName};
      response = await post(
        "http://47.107.117.59/fff/register.php",
        body: {'mail': "mail", 'password': "password", 'nick': "userName"},
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
        title: Text('注册账户'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: '电子邮箱',
                ),
                onChanged: (text) {
                  mail = text;
                  print('mail:$mail');
                },
                maxLength: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '昵称',
                ),
                onChanged: (text) {
                  userName = text;
                  print('username:$userName');
                },
                maxLength: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '密码',
                ),
                onChanged: (text) {
                  password = text;
                  print('password:$password');
                },
                maxLength: 30,
              ),
              
              FlatButton(
                onPressed: () {
                  CreateAccount();
                },
                child: Container(
                  height: 40,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      'Done',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  // TextFormField buildEmailTextField() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       labelText: 'Emall Address',
  //     ),
  //     onChanged: (text) {
  //                 password = text;
  //                 print('$password');
  //               },
  //     validator: (String value) {
  //       var emailReg = RegExp(
  //           r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
  //       if (!emailReg.hasMatch(value)) {
  //         return '请输入正确的邮箱地址';
  //       }
  //     },
  //     onSaved: (String value) => mail = value,
  //   );
  // }
}
// Row(
//   children: <Widget>[
//     Expanded(
//       flex: 5,
//       child: TextField(
//         decoration: InputDecoration(
//             hintText: '验证码',
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             )),
//         maxLength: 6,
//       ),
//     ),
//     Expanded(
//       flex: 3,
//       child: FlatButton(
//         onPressed: () {
//           //Navigator.pop(context);
//         },
//         child: Container(
//           //height: 30,
//           //width: 80,
//           decoration: BoxDecoration(
//             //color: Colors.grey,
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//           child: Center(
//             child: Text(
//               '发送验证码',
//             ),
//           ),
//         ),
//       ),
//     )
//   ],
// ),
//
