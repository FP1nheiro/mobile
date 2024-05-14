import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({ Key? key }) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o NEPA'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
                'assets/images/nepa.png'), // Certifique-se de ter uma imagem relevante em seus ativos
            SizedBox(height: 20),
            Text(
              'Núcleo de Extensão e Pesquisa Acadêmica (NEPA)',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 20),
            Text(
              'O NEPA da Faculdade Católica da Paraíba, antiga FAFIC, em Cajazeiras, Paraíba, é um centro de inovação e pesquisa dedicado à promoção humana e transformação social através da ciência. Com um forte compromisso com o bem-estar cidadão, o NEPA desenvolve projetos de extensão que são tanto educativos quanto preventivos, evitando um caráter meramente assistencialista.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 20),
            Text(
              'Compromisso com a Comunidade',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            Text(
              'Integrando ensino, pesquisa e extensão, o NEPA está no coração da estratégia da Faculdade Católica da Paraíba para produzir e socializar conhecimento e cultura, fortalecendo a relação entre a instituição e a comunidade através de programas que atendem aos interesses públicos.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 20),
            Text(
              'Dimensões da Extensão',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            Text(
              '• Relações entre a instituição de ensino superior e a sociedade;\n• Interações entre a sociedade e a instituição de ensino superior;\n• Atividades realizadas dentro da própria instituição.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
