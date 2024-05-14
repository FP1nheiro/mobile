import 'package:flutter/material.dart';
import 'package:mobile/models/project.dart';
import 'package:mobile/utils/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisteredProjectsPage extends StatefulWidget {
  @override
  _RegisteredProjectsPageState createState() => _RegisteredProjectsPageState();
}

class _RegisteredProjectsPageState extends State<RegisteredProjectsPage> {
  Tema tema = Tema();

  @override
  void initState() {
    super.initState();
    tema.loadRegisteredProjects().then((_) {
      setState(() {});  // Atualiza o estado após os projetos serem carregados
    });
  }

  void unregisterFromProject(Project project) async {
    final prefs = await SharedPreferences.getInstance();
    tema.registeredProjects.remove(project);
    List<String> savedProjectsNames = tema.registeredProjects.map((p) => p.name).toList();
    await prefs.setStringList('registeredProjects', savedProjectsNames);
    setState(() {});  // Atualiza a UI após a remoção de um projeto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Projetos"),
      ),
      body: ListView.builder(
        itemCount: tema.registeredProjects.length,
        itemBuilder: (context, index) {
          Project project = tema.registeredProjects[index];
          return ListTile(
            title: Text(project.name),
            subtitle: Text(project.description),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => unregisterFromProject(project),
            ),
          );
        },
      ),
    );
  }
}
