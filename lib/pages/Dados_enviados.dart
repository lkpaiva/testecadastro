import 'package:flutter/material.dart';

class DadosEnviados extends StatefulWidget {
  const DadosEnviados({super.key});

  @override
  State<DadosEnviados> createState() => _DadosEnviadosState();
}

class _DadosEnviadosState extends State<DadosEnviados> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 30.0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            children: <Widget>[
              Image.asset(
                'Assets/images/logo_ademicon.png',
                width: 150,
                height: 150,
              ),
              Divider(),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5.0),
                child: Center(
                  child: Text( " \n\n\n\n\n\n Seus dados foram recebidos com sucesso!"
                      "\n Entraremos em contato "
                      "\n para prosseguirmos para "
                      "\n as proximas etapas. "
                      "\n Obrigado!",
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.center,
                        ),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
