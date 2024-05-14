import 'package:flutter/material.dart';
import 'package:nepa/models/project.dart';
import 'package:nepa/pages/project_signup.page.dart';
import 'package:nepa/utils/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjetosDiponiveisPage extends StatefulWidget {
  @override
  _ProjetosDiponiveisPageState createState() => _ProjetosDiponiveisPageState();
}

class _ProjetosDiponiveisPageState extends State<ProjetosDiponiveisPage> {
  Tema tema = Tema(); // Acessa a instância global de Tema

  @override
  void initState() {
    super.initState();
    loadUserProjects();
  }

  void loadUserProjects() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> projectNames = prefs.getStringList('registeredProjects') ?? [];
    List<Project> projects = projectNames.map((name) {
      return Tema.availableProjects.firstWhere(
          (project) => project.name == name,
          orElse: () =>
              Project(name: "Unknown", description: "Project not found"));
    }).toList();

    setState(() {
      tema.registeredProjects = projects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Projetos Disponíveis")),
      body: ListView.builder(
        itemCount: Tema.availableProjects.length,
        itemBuilder: (context, index) {
          Project project = Tema.availableProjects[index];
          bool isRegistered =
              tema.registeredProjects.any((p) => p.name == project.name);
          return ListTile(
            title: Text(project.name),
            subtitle: Text(project.description),
            trailing: isRegistered
                ? Icon(Icons.check, color: Colors.green)
                : IconButton(
                    icon: Icon(Icons.add),
                    onPressed: tema.registeredProjects.length < 2
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProjectSignUpPage(
                                        project: project, userData: tema)));
                          }
                        : null,
                  ),
          );
        },
      ),
    );
  }
}
