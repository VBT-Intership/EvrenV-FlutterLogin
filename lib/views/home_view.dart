import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(backgroundColor: Colors.white, body: buildBody(context)),
    );
  }

  Row buildBody(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Spacer(flex: 1),
        Flexible(
          flex: 8,
          child: Center(child: buildMainContainer(context)),
        ),
        Spacer(flex: 1)
      ],
    );
  }

  Column buildMainContainer(BuildContext context) =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        buildSuccessIcon(),
        buildIconTitle(),
        buildWelcomeTitle(context),
      ]);

  Text buildWelcomeTitle(BuildContext context) {
    return Text(
      "Welcome to Hysys",
      style: Theme.of(context)
          .textTheme
          .headline4
          .copyWith(fontWeight: FontWeight.w300, color: Colors.black87),
    );
  }

  Padding buildIconTitle() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Text(
          "Sign In Successful!",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );

  Image buildSuccessIcon() =>
      Image(image: AssetImage('assets/success_icon.png'));
}
