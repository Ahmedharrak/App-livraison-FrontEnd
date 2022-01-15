import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:livreurs_app/views/Inscrire/mainInscrire.dart';
import 'package:livreurs_app/views/Login/loginScreen.dart';

class MainI extends StatefulWidget {
  @override
  mainIState createState() => mainIState();
}

// ignore: camel_case_types
class mainIState extends State<MainI> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Center(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            ' Livraison GV',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/logo.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Material(
              color: Colors.white,
              child: TabBar(
                indicatorColor: Colors.orange,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                tabs: [Tab(text: "Se Connecter"), Tab(text: "S’inscrire")],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            LogIn(),
            MainIns(),
          ],
        ),
      ),
    );
  }
}
