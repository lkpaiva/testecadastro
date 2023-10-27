import 'package:cadastro/pages/CadastroEnderecoEstadoCivil.dart';
import 'package:cadastro/pages/Dados_enviados.dart';
import 'package:cadastro/pages/cadastro_basico.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    print(brightness);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cadastro",
      theme: ThemeData(
          brightness : brightness,
      ),
      home: const CadastroBasico(),
      routes: {
        '/cadastro_basico' : (context) => const CadastroBasico(),
        "/CadastroEnderecoEstadoCivil" : (context) => const CadastroEnderecoEstadoCivil(),
        '/Dados_enviados' : (context) => const DadosEnviados(),
      },
    );
  }
}
