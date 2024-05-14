import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:mobile/utils/style.dart';
=======
import 'package:nepa/utils/style.dart';
>>>>>>> filipe
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _cursoSelecionado;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    _nomeController.text = prefs?.getString(Tema().nome) ?? '';
    _matriculaController.text =
        prefs?.getString(Tema().matricula.toString()) ?? '';
    _emailController.text = prefs?.getString(Tema().email) ?? '';
    _cursoSelecionado = prefs?.getString(Tema().curso) ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Perfil"),
          centerTitle: true,
          backgroundColor: Tema().corPrimeira,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                buildTextField(_nomeController, Icons.person, "Nome", "", false,
                    TextInputType.name),
                buildTextField(_emailController, Icons.email, "E-mail",
                    "Digite seu e-mail", true, TextInputType.emailAddress),
                buildTextField(_matriculaController, Icons.school, "Matrícula",
                    "", false, TextInputType.number),
                const SizedBox(height: 1),
                if (_cursoSelecionado != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 37, vertical: 17),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Text("Curso: $_cursoSelecionado",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _savePreferences,
                  child: const Text("Salvar Alterações"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, IconData icon,
      String label, String hintText, bool enabled, TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          hintText: hintText,
          alignLabelWithHint: true,
          labelStyle: TextStyle(
            color: enabled
                ? const Color.fromARGB(255, 0, 0, 0)
                : const Color.fromARGB(
                    255, 0, 0, 0), // Cor do rótulo baseado no estado enabled
            fontWeight: FontWeight
                .bold, // Pode adicionar estilo de fonte como negrito, se necessário
          ),
          fillColor: enabled ? Colors.white : Colors.grey[300],
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  Future<void> _savePreferences() async {
    await prefs?.setString(Tema().nome, _nomeController.text);
    await prefs?.setString(Tema().email, _emailController.text);
    await prefs?.setString(
        Tema().matricula.toString(), _matriculaController.text);
    setState(() {
      _emailController.text = _emailController.text;
    });
  }
}
