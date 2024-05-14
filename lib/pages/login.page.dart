import 'package:flutter/material.dart';
import 'package:mobile/pages/home.page.dart';
import 'package:mobile/utils/style.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _verSenha = true;

  @override
  void initState() {
    super.initState();
    _verSenha = false;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _senhaController = TextEditingController();

    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 153, 181, 204),
        title: const Text("Login",
            style: TextStyle(
                color: Color.fromARGB(255, 37, 37, 37),
                fontFamily: 'OpenSans',
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 153, 181, 204),
              Color.fromARGB(255, 203, 223, 253)
            ], // Ajuste as cores conforme desejado
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 50),
                child: Image.asset(
                  Tema().logoHorizontal,
                  width: 300,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 315.0,
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 40.0),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                                width: 2.5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.purple, width: 2.5)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        alignLabelWithHint: true,
                        label: const Text("E-mail"),
                        hintText: "Digite seu e-mail",
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(137, 255, 255, 255),
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 60),
                    width: 315.0,
                    child: TextField(
                      controller: _senhaController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_verSenha,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 40.0),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.purple, width: 2.5)),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                                width: 2.5)),
                        prefixIcon: const Icon(
                          Icons.password_rounded,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_verSenha
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _verSenha = !_verSenha;
                            });
                          },
                        ),
                        alignLabelWithHint: true,
                        label: const Text("Password"),
                        hintText: "Digite sua senha",
                        hintStyle: const TextStyle(
                          color: Colors.white54,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      String email = prefs.getString(Tema().email)!;
                      String senha = prefs.getString(Tema().senha)!;

                      // Verifica se o email e a senha são iguais aos dados salvos
                      bool emailCorreto = _emailController.text == email;
                      bool senhaCorreta = _senhaController.text == senha;

                      if (emailCorreto && senhaCorreta) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    } catch (Exception) {}
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      Size(width - 100, 60),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF002266)),
                  ),
                  child: const Text(
                    "Entrar",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 17),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
