import 'package:flutter/material.dart';

class TermosPage extends StatefulWidget {
  const TermosPage({Key? key}) : super(key: key);

  @override
  _TermosPageState createState() => _TermosPageState();
}

class _TermosPageState extends State<TermosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Termos e Serviços'),
        backgroundColor: Colors
            .deepPurple, // Você pode ajustar a cor conforme sua identidade visual
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Ao acessar e usar este aplicativo, você concorda em cumprir os seguintes termos de serviço, '
          'que juntos com nossa política de privacidade regem a relação com você em relação a este aplicativo. '
          'Se você discordar de alguma parte dos termos, por favor não utilize nosso serviço.\n\n'
          'O uso do aplicativo é sujeito aos seguintes termos de uso:\n\n'
          '1. O conteúdo das páginas deste aplicativo é para sua informação geral e uso somente. '
          'Está sujeito a alteração sem aviso prévio.\n\n'
          '2. Nem nós nem terceiros fornecemos qualquer garantia ou garantia quanto à precisão, '
          'atualidade, desempenho, integridade ou adequação das informações e materiais encontrados '
          'ou oferecidos neste aplicativo para qualquer propósito específico. Você reconhece que tais '
          'informações e materiais podem conter imprecisões ou erros e nós expressamente excluímos '
          'responsabilidade por tais imprecisões ou erros na máxima extensão permitida por lei.\n\n'
          '3. Seu uso de qualquer informação ou material neste aplicativo é inteiramente por sua conta e risco, '
          'pelo qual não seremos responsáveis. Será sua própria responsabilidade garantir que quaisquer produtos, '
          'serviços ou informações disponíveis através deste aplicativo atendam às suas exigências específicas.\n\n'
          '4. Este aplicativo inclui materiais que são protegidos por direitos autorais e marcas registradas. '
          'Estes materiais incluem, mas não estão limitados ao design, layout, aparência, interface e gráficos. '
          'A reprodução é proibida.\n\n'
          '5. Todos os direitos autorais, marcas registradas e outros direitos de propriedade intelectual no aplicativo e seu conteúdo são de propriedade de ou licenciados para nós.\n\n'
          '6. O uso não autorizado deste aplicativo pode dar origem a uma reivindicação por danos e/ou ser um delito criminal.\n\n'
          '7. De tempos em tempos, este aplicativo também pode incluir links para outros aplicativos ou websites. '
          'Esses links são fornecidos para sua conveniência para fornecer mais informações. Eles não significam que '
          'endossamos o(s) aplicativo(s) ou site(s). Não temos responsabilidade pelo conteúdo do(s) aplicativo(s) ou site(s) vinculado(s).\n\n'
          '8. Seu uso deste aplicativo e qualquer disputa decorrente de tal uso do aplicativo está sujeito às leis de Brasil.\n\n'
          'Por favor, revise também nossa Política de Privacidade.',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
