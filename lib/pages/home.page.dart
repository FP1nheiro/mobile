import 'dart:io';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile/pages/dados.page.dart';
import 'package:mobile/pages/login.page.dart';
import 'package:mobile/pages/profile.page.dart';
import 'package:mobile/pages/project_disponiveis.page.dart';
import 'package:mobile/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  SharedPreferences? prefs;
  File? _image;

  int _current = 0;

  signOut() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeController.text = prefs?.getString(Tema().nome) ?? '';
      _emailController.text = prefs?.getString(Tema().email) ?? '';

      String? imagePath = prefs?.getString(Tema().image);
      if (imagePath != null) {
        _image = File(imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          centerTitle: true,
          backgroundColor: Tema().corPrimeira,
          foregroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );

                // Após retornar da página de perfil, recarrega as preferências para atualizar a imagem
                await _loadPreferences();
                setState(() {}); // Atualiza a interface com a nova imagem
              },
              icon: const Icon(
                Icons.person_3_outlined,
                size: 34,
              ),
            ),
          ],
        ),
        floatingActionButton: SizedBox(
          height: 55,
          width: 55,
          child: FloatingActionButton(
            onPressed: () {
              signOut();
            },
            backgroundColor: Colors.green.withOpacity(0.65),
            child: const Icon(
              size: 26,
              Icons.logout_rounded,
              color: Colors.black,
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                arrowColor: Colors.black,
                decoration: BoxDecoration(
                  color: Tema().corPrimeira,
                ),
                accountName: Text(_nomeController.text),
                accountEmail: Text(_emailController.text),
                currentAccountPicture: InkWell(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90.5),
                          image: _image != null
                              ? DecorationImage(
                                  image: FileImage(_image!), fit: BoxFit.cover)
                              : null,
                          color: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: Text('Meus Dados'),
                onTap: () async {
                await Navigator.push(
                     context,
                     MaterialPageRoute(
                          builder: (context) => const DadosPage()));
                  await _loadPreferences();
                  setState(() {});
                },
              ),
              ListTile(
                leading: Icon(Icons.settings_suggest_outlined),
                title: Text('Configurações'),
                onTap: () async {
                 // await Navigator.push(
                    //  context,
                     // MaterialPageRoute(
                      //    builder: (context) => const ProfilePage()));
                  await _loadPreferences();
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            buildCarousel(),
            const SizedBox(height: 70),
            buildElevatedButtonField(500, 'Projetos Disponiveis', () {Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProjetosDiponiveisPage()));})
          ],
        ),
      ),
    );
  }

  Widget buildCarousel() {
    List<String> images = [
      'assets/images/nepa.png',
      'assets/images/faculdade.png',
    ];

    return CarouselSlider.builder(
      itemCount: images.length,
      options: CarouselOptions(
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 1),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final blur = index != _current ? 5.0 : 0.0;

        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: const Border(
                      left: BorderSide(
                        color: Color.fromARGB(255, 178, 176, 176),
                        width: 2.5,
                      ),
                      right: BorderSide(
                        color: Color.fromARGB(255, 178, 176, 176),
                        width: 2.5,
                      ),
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 178, 176, 176),
                        width: 2.5,
                      ),
                      top: BorderSide(
                        color: Color.fromARGB(255, 178, 176, 176),
                        width: 2.5,
                      ),
                    ),
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                      child: Container(
                        color: const Color.fromARGB(255, 247, 169, 169)
                            .withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildElevatedButtonField(
      double width, String buttonText, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(width - 200, 48)),
        backgroundColor: MaterialStateProperty.all(Tema().corPrimeira),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
