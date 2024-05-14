import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/pages/initial.page.dart';
import 'package:mobile/utils/style.dart';


class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const InitialPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 203, 212, 250),
                Color.fromARGB(255, 145, 165, 255),
                Color.fromARGB(255, 76, 133, 255)
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  Tema().logoSimples,
                  height: 300,
                  width: 300,
                ),
                const Text(
                  "Saudações,\n agradecemos por usar\n nosso aplicativo do NEPA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // texto
                const Text(
                  "Versão 0.0.1.pre-alpha",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //       child: Scaffold(
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: <Widget>[
  //           Image.asset(
  //             Tema().logoSimples,
  //             height: 300,
  //             width: 300,
  //           ),
  //           const Text(
  //             "Saudações,\n agradecemos por usar\n nosso aplicativo do NEPA",
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: Color.fromARGB(255, 0, 0, 0),
  //               fontSize: 13,
  //             ),
  //           ),
  //           // texto
  //           const Text(
  //             "Versão 0.0.1.pre-alpha",
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: Color.fromARGB(255, 0, 0, 0),
  //               fontSize: 14,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ));
  // }
}
