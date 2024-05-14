// ProjectSignUpPage.dart
import 'package:flutter/material.dart';
import 'package:mobile/models/project.dart';
import 'package:mobile/utils/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectSignUpPage extends StatefulWidget {
  final Project project;
  final Tema userData;

  const ProjectSignUpPage(
      {super.key, required this.project, required this.userData});

  @override
  _ProjectSignUpPageState createState() => _ProjectSignUpPageState();
}

class _ProjectSignUpPageState extends State<ProjectSignUpPage> {
  SharedPreferences? prefs;

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    _nomeController.text = prefs!.getString(Tema().nome) ?? "";
    _matriculaController.text =
        prefs!.getString(Tema().matricula.toString()) ?? "";
    _emailController.text = prefs!.getString(Tema().email) ?? "";
  }

  void signUpForProject() async {
    List<String> savedProjects =
        prefs!.getStringList('registeredProjects') ?? [];
    if (savedProjects.length >= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Você já está inscrito em dois projetos.")),
      );
      return;
    }
    if (!savedProjects.contains(widget.project.name)) {
      savedProjects.add(widget.project.name);
      await prefs!.setStringList('registeredProjects', savedProjects);
      Navigator.pop(context); // Retorna à tela anterior após a inscrição
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Inscrição no projeto '${widget.project.name}' confirmada.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Você já está inscrito neste projeto.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inscrição no Projeto"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                widget.project.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(widget.project.description),
              SizedBox(height: 20),
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: "Nome"),
                readOnly: true,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                readOnly: true,
              ),
              TextField(
                controller: _matriculaController,
                decoration: InputDecoration(labelText: "Curso"),
                readOnly: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: signUpForProject,
                child: Text("Confirmar Inscrição"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancelar"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
