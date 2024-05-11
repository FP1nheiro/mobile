import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepa/utils/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DadosPage extends StatefulWidget {
  const DadosPage({Key? key}) : super(key: key);

  @override
  State<DadosPage> createState() => _DadosPageState();
}

class _DadosPageState extends State<DadosPage> {
  File? _image;
  SharedPreferences? prefs;

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
      _loadPreferences(); // Atualiza a imagem imediatamente após a seleção
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
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 100),
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
                  GestureDetector(
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
                                    image: FileImage(_image!),
                                    fit: BoxFit.cover)
                                : null,
                            color: Colors.grey[200],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.camera_enhance,
                                color: Colors.green, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {}, // Replace with actual functionality
                          child: Text(
                            'Acessibilidade', // Accessibility in Portuguese
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            side: BorderSide(width: 3),
                              shape: LinearBorder.bottom(
                                  side: BorderSide(color: Colors.blue),
                                  size: 0)),
                        )
                      ],
                    ),
                  ),
                  Container(
                      child: Column(
                    children: <Widget>[
                      OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                          child: const Text(
                            "Meus Dados",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20),
                          ))
                    ],
                  )),
                ],
              )))
        ],
      ),
    );
  }
}
