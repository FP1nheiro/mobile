import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/pages/about.page.dart';
import 'package:mobile/pages/changePassword.page.dart';
import 'package:mobile/pages/login.page.dart';
import 'package:mobile/pages/profile.page.dart';
import 'package:mobile/pages/project_registred.page.dart';
import 'package:mobile/pages/suporte.page.dart';
import 'package:mobile/pages/termos.page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/utils/style.dart';

class DadosPage extends StatefulWidget {
  const DadosPage({Key? key}) : super(key: key);

  @override
  State<DadosPage> createState() => _DadosPageState();
}

class _DadosPageState extends State<DadosPage> {
  File? _image;
  SharedPreferences? prefs;

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
    String? imagePath = prefs?.getString(Tema().image);

    if (imagePath != null) {
      _image = File(imagePath);
    }
    setState(() {});
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await prefs?.setString(Tema().image, pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Configurações da Conta",
            style: TextStyle(
                color: Color.fromARGB(255, 37, 37, 37),
                fontFamily: 'OpenSans',
                fontSize: 23,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Center(
            child: InkWell(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 201, 255, 138),
                          width: 3),
                      borderRadius: BorderRadius.circular(50.5),
                      image: _image != null
                          ? DecorationImage(
                              image: FileImage(_image!), fit: BoxFit.cover)
                          : null,
                      color: Colors.grey[200],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
                      child: Icon(Icons.camera_enhance,
                          color: Colors.green, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Editar Perfil'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Mudar Senha'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.personal_injury),
            title: Text('Meus Projetos'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisteredProjectsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Sobre o Aplicativo'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Termos de Serviço'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TermosPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.support),
            title: Text('Suporte (Entrar em Contato)'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SuportePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              signOut();
            },
          ),
        ],
      ),
    );
  }
}
