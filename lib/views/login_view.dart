import 'package:flutter/material.dart';

import 'package:login_view/core/constant/route_name.dart';
import 'package:login_view/core/model/user_request.dart';
import 'package:login_view/core/service/auth_service.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  bool isAutoValidate = false;

  UserRequest userRequest = UserRequest();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          key: scaffold,
          backgroundColor: Colors.white,
          body: buildBody(context)),
    );
  }

  Row buildBody(BuildContext context) {
    return Row(
      children: <Widget>[
        Spacer(flex: 1),
        Flexible(flex: 8, child: buildMainContainer(context)),
        Spacer(flex: 1)
      ],
    );
  }

  Column buildMainContainer(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(flex: 2),
        Flexible(
          flex: 8,
          child: buildMainCard(context),
        ),
        Spacer(flex: 3),
      ],
    );
  }

  Column buildMainCard(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 2, child: buildTopBoard(context)),
          Flexible(flex: 3, child: buildWelcomeBoard()),
          Flexible(flex: 7, child: buildForm()),
        ]);
  }

  Form buildForm() {
    return Form(
      key: formState,
      autovalidate: isAutoValidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildEmailFormField(),
          buildPasswordFormField(),
          buildSubmitForm(),
        ],
      ),
    );
  }

  Container buildSubmitForm() {
    return Container(
      margin: EdgeInsets.only(top: 23.0),
      child: buildButton(),
    );
  }

  MaterialButton buildButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.0),
      ),
      color: Colors.blueAccent,
      textColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
        child: Text(
          "Sign In",
          style: TextStyle(fontSize: 15),
        ),
      ),
      onPressed: () async {
        if (formState.currentState.validate()) {
          formState.currentState.save();

          final haveUser = await AuthService.postUser(userRequest);

          if (haveUser) {
            Navigator.pushNamed(context, RouteName.HOME);
          } else {
            scaffold.currentState
                .showSnackBar(SnackBar(content: Text("Hatalı Giriş")));
          }
        }
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(fontSize: 18, color: Colors.black87),
          suffixText: "Forgot Password?",
          suffixStyle: TextStyle(color: Colors.blue)),
      validator: (value) {
        return value.length > 5
            ? null
            : "Password must be at least 6 characters";
      },
      onSaved: (value) {
        userRequest.password = value.trim();
      },
      obscureText: true,
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email address",
        labelStyle: TextStyle(fontSize: 18, color: Colors.black87),
      ),
      validator: (value) {
        return value.contains(RegExp(r'[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}'))
            ? null
            : "Invalid E-mail";
      },
      onSaved: (value) {
        userRequest.email = value.trim();
      },
    );
  }

  Column buildWelcomeBoard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Welcome!",
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(fontWeight: FontWeight.w300, color: Colors.black87),
        ),
        Text(
          "Please Sign-in to continue",
          style: Theme.of(context).textTheme.headline6.copyWith(
              fontWeight: FontWeight.w300, color: Colors.black87, fontSize: 16),
        ),
      ],
    );
  }

  Column buildTopBoard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTopBoardIcon(context),
        buildTopBoardTitle(context)
      ],
    );
  }

  Padding buildTopBoardTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Employee Login",
        style: TextStyle(
            fontSize: 13.0, color: Colors.black87, fontWeight: FontWeight.w600),
      ),
    );
  }

  Row buildTopBoardIcon(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "Hysys",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.w700, color: Colors.lightBlue),
        ),
        Icon(
          Icons.keyboard_arrow_right,
          size: 22,
          color: Colors.lightBlue,
        ),
      ],
    );
  }
}
