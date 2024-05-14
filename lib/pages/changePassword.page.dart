import 'package:flutter/material.dart';
import 'package:mobile/utils/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trocar Senha'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Troque sua senha',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            buildTextField(_currentPasswordController, 'Senha Atual', true),
            const SizedBox(height: 10),
            buildTextField(_newPasswordController, 'Nova Senha', true),
            const SizedBox(height: 10),
            buildTextField(
                _confirmNewPasswordController, 'Confirmar Nova Senha', true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _passwordChange,
              child: const Text('Confirmar Troca'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      TextEditingController controller, String label, bool obscureText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
    );
  }

  Future<void> _passwordChange() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPassword = prefs.getString(Tema().senha);

        if (_newPasswordController.text.isEmpty ||
        _confirmNewPasswordController.text.isEmpty) {
      dialogShow(
          'Campos vazios.', 'Por favor, preencha todos os campos vazios!');
      return;
    }

    if (_currentPasswordController.text != storedPassword) {
      dialogShow('Senha Incorreta',
          'A sua senha atual digitada está incorreta, por favor digita novamente!');
      return;
    }

    if (_newPasswordController.text != _confirmNewPasswordController.text) {
      dialogShow('Senhas não conicidem', 'As senhas digitadas para mudança não são iguais!');
      return;
    }

    await prefs.setString(Tema().senha, _confirmNewPasswordController.text);

    dialogShow('Senha Alterada', 'Sua senha foi alterada com sucesso!');

    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmNewPasswordController.clear();
  }

  dialogShow(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
