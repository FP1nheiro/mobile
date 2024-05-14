import 'package:flutter/material.dart';
import 'package:mobile/utils/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuportePage extends StatefulWidget {
  const SuportePage({Key? key}) : super(key: key);

  @override
  _SuportePageState createState() => _SuportePageState();
}

class _SuportePageState extends State<SuportePage> {
  SharedPreferences? prefs;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    _nameController.text = prefs!.getString(Tema().nome) ?? "";
    _emailController.text = prefs!.getString(Tema().email) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suporte e Contato'),
        backgroundColor:
            Colors.deepPurple, // Ajuste conforme a identidade visual do app
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Precisa de ajuda? Entre em contato conosco!',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                enabled: false,
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabled: false,
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Mensagem',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _sendSupportRequest(context),
              child: Text('Enviar Mensagem'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green, // Botão verde para enviar a mensagem
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Você também pode nos contatar diretamente:',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 10),
            Text('E-mail: suporte@faculdadecatolica.com.br',
                style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height: 5),
            Text('Telefone: (83) 4002-8922',
                style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
    );
  }

  void _sendSupportRequest(BuildContext context) {
    // Aqui você adicionaria a lógica para enviar a mensagem para o suporte
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mensagem Enviada'),
          content: Text(
              'Sua mensagem foi enviada com sucesso. Entraremos em contato em breve!'),
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
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  Future<void> registerContact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _messageController.text.isNotEmpty) {
      await prefs.setString(Tema().nome, _nameController.text);
      await prefs.setString(Tema().email, _emailController.text);
      await prefs.setString(Tema().message, _messageController.text);
    }
  }
}