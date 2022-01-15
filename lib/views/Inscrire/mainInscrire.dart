import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:livreurs_app/views/Inscrire/inscrireClient.dart';
import 'package:livreurs_app/views/Inscrire/inscrireLivreur.dart';
import 'package:livreurs_app/views/Login/mainLogin.dart';

class MainIns extends StatefulWidget {
  @override
  mainInsState createState() => mainInsState();
}

// ignore: camel_case_types
class mainInsState extends State<MainIns> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //////////////////////////////// bar de page //////////////////////////////
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),

          /////////////////////////////// TabBar Application //////////////////////////
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Material(
              child: Container(
                child: TabBar(
                  indicatorColor: Colors.orange,
                  labelColor: Colors.orangeAccent,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: "Client",
                    ),
                    Tab(text: "Livreur")
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            InscrireClient(),
            InscrireLivreur(),
          ],
        ),
      ),
    );
  }
}
