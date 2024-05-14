import 'package:flutter/material.dart';
import 'package:nepa/models/project.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tema {
  // imagens
  String logoSimples = "assets/images/faculdade.png";
  String logoHorizontal = "assets/images/nepa.png";

  // cores
  Color corPrimeira = const Color(0xFF002266);

  // chaves de dados
  String email = "email";
  String senha = "senha";
  String curso = "curso";
  String message = "a";
  int matricula = 20210073;
  int telefone = 83998440049;
  String nome = "nome";
  String image = "";
  String projectName = "";
  bool project = false;

  // Lista para armazenar projetos
  List<Project> registeredProjects = [];

  static List<Project> availableProjects = [
    Project(name: "Projeto 1", description: "Descrição do Projeto 1"),
    Project(name: "Projeto 2", description: "Descrição do Projeto 2"),
    Project(name: "Projeto 3", description: "Descrição do Projeto 3"),
  ];


    Future<void> loadRegisteredProjects() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> projectNames = prefs.getStringList('registeredProjects') ?? [];
    registeredProjects = projectNames.map((name) => 
      availableProjects.firstWhere((project) => project.name == name, orElse: () => Project(name: "Unknown", description: "No description available"))
    ).toList();
  }
}
