import 'package:flutter/material.dart';
import 'package:nepa/pages/create_account.page.dart';
import 'package:nepa/pages/login.page.dart';

import '../utils/style.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 203, 212, 250),
                  Color.fromARGB(255, 145, 165, 255),
                  Color.fromRGBO(76, 133, 255, 1)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Image.asset(
                      Tema().logoHorizontal,
                      width: 300,
                    ),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        child: Text(
                          'Seja Bem-Vindo ao NEPA Mobile',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: 'OpenSans',
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                Size(width - 125, 55),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF002266))),
                          child: const Text(
                            "Fazer Login",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 35),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => CreateAccountPage()));
                          },
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              Size(width - 125, 55),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF002266)),
                          ),
                          child: const Text(
                            "Criar Conta",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
