import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/widgets/LoginFormField.dart';
import 'package:flutter_base_app/src/widgets/NoGlowConfiguration.dart';

class LoginScreen extends StatelessWidget {
  final backgroundBlack = Color.fromRGBO(90, 90, 90, 1);
  build(context) {
    return Scaffold(
      body: Container(
        color: backgroundBlack,
        child: ScrollConfiguration(
          behavior: NoGlowScroll(),
          child: ListView(
            children: [
              AppBar(
                backgroundColor: backgroundBlack,
                elevation: 0,
                leading: FlatButton(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white60,
                  ),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Log In',
                        style: TextStyle(fontSize: 40, color: Colors.white60)),
                    SizedBox(
                      height: 80,
                    ),
                    LoginFormField(
                      icon: Icons.person,
                      label: 'Username',
                    ),
                    LoginFormField(
                      icon: Icons.lock,
                      label: 'Password',
                      isObscured: true,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: ButtonTheme(
                          height: 50,
                          child: RaisedButton(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text('Log In',
                                style: TextStyle(
                                    color: Colors.white60, fontSize: 25)),
                            color: Color.fromRGBO(0, 0, 0, 0.9),
                            onPressed: () {},
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
