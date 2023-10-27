import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cadastro/mixin/validations_mixin.dart';
import 'package:validadores/Validador.dart';
import '../models/users.dart';
import '../models/viacep.dart';

class CadastroEnderecoEstadoCivil extends StatefulWidget {
  const CadastroEnderecoEstadoCivil({super.key});

  @override
  State<CadastroEnderecoEstadoCivil> createState() =>
      _CadastroEnderecoEstadoCivilState();
}

class _CadastroEnderecoEstadoCivilState
    extends State<CadastroEnderecoEstadoCivil> with ValidationsMixin{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController logradouroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  var isMarried = "Solteiro";
  final User _user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 30.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Image.asset(
                    'Assets/images/logo_ademicon.png',
                    width: 150,
                    height: 150,
                  ),
                  Divider(),
                  const Text("Cadastro",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                      textAlign: TextAlign.justify),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: TextFormField(
                            onSaved: (value) {
                              _user.CEP = value.toString();
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter(),
                            ],
                            onChanged: (value) async {
                              final cleanedValue = value.replaceAll(
                                  RegExp(r'[^0-9]'),
                                  '');
                              if (cleanedValue.length == 8) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return FutureBuilder(
                                          future: ViaCepApi.makeRequest(
                                              cleanedValue.toString()),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              final data = snapshot.data
                                                  as Map<String, dynamic>;

                                              logradouroController.text =
                                                  data['logradouro'] ?? '';
                                              cidadeController.text =
                                                  data['localidade'] ?? '';
                                              estadoController.text =
                                                  data['uf'] ?? '';
                                              bairroController.text =
                                                  data['bairro'] ?? '';

                                              Navigator.of(context).pop();
                                            }
                                            // if(snapshot.hasError){
                                            //   SnackBar(content: context),
                                            // }
                                            return AlertDialog(
                                              title: Text("Buscando Endereço"),
                                              content: Row(
                                                children: [
                                                  CircularProgressIndicator(),
                                                  Text("Aguarde..."),
                                                ],
                                              ),
                                            );
                                          });
                                    });
                              }
                            },
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.blueAccent),
                            decoration: const InputDecoration(
                                labelText: " CEP",
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                )),
                            validator: (value) => isNotEmpty(value, "Preencha o campo CEP"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: TextFormField(
                            onSaved: (value) {
                              _user.Numero = value.toString();
                            },
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.blueAccent),
                            decoration: const InputDecoration(
                                labelText: " Número",
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: TextFormField(
                      onSaved: (value) {
                        _user.Logradouro = value.toString();
                      },
                      style: const TextStyle(color: Colors.blueAccent),
                      decoration: const InputDecoration(
                          labelText: " Logradouro",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          )),
                      controller: logradouroController,
                      validator: (value) => isNotEmpty(value, "Preencha o campo logradouro"),
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: TextFormField(
                          onSaved: (value) {
                            _user.Quadra = value.toString();
                          },
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.blueAccent),
                          decoration: const InputDecoration(
                              labelText: " Quadra",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              )),
                          validator: (value) => isNotEmpty(value, "Preencha o campo Quadra"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: TextFormField(
                          onSaved: (value) {
                            _user.Lote = value.toString();
                          },
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.blueAccent),
                          decoration: const InputDecoration(
                              labelText: " Lote",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              )),
                          validator: (value) => isNotEmpty(value, "Preencha o campo Lote"),
                        ),
                      ),
                    ),
                  ]),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: TextFormField(
                      onSaved: (value) {
                        _user.Bairro = value.toString();
                      },
                      style: const TextStyle(color: Colors.blueAccent),
                      decoration: const InputDecoration(
                          labelText: " Bairro",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          )),
                      controller: bairroController,
                      validator: (value) => isNotEmpty(value, "Preencha o campo Bairro"),
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: TextFormField(
                          onSaved: (value) {
                            _user.UF = value.toString();
                          },
                          style: const TextStyle(color: Colors.blueAccent),
                          decoration: const InputDecoration(
                              labelText: " Estado",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              )),
                          controller: estadoController,
                          validator: (value) => isNotEmpty(value, "Preenha o campo Estado"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: TextFormField(
                          onSaved: (value) {
                            _user.Cidade = value.toString();
                          },
                          style: const TextStyle(color: Colors.blueAccent),
                          decoration: const InputDecoration(
                              labelText: " Cidade",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              )),
                          controller: cidadeController,
                          validator: (value) => isNotEmpty(value, "Preenha o campo Cidade"),
                        ),
                      ),
                    ),
                  ]),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: const Text("Estado Civil"),
                  ),
                  Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RadioListTile(
                            title: const Text("Solteiro"),
                            value: "Solteiro",
                            groupValue: isMarried,
                            onChanged: (value) {
                              setState(() {
                                isMarried = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text("Casado"),
                            value: "Casado",
                            groupValue: isMarried,
                            onChanged: (value) {
                              setState(() {
                                isMarried = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    isMarried == "Solteiro"
                        ? const SizedBox(width: 0)
                        : Column(children: <Widget>[
                            const Divider(),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Dados do conjuge"),
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: TextFormField(
                                    onSaved: (value) {
                                      _user.NomeConjuge = value.toString();
                                    },
                                    style: const TextStyle(
                                        color: Colors.blueAccent),
                                    decoration: const InputDecoration(
                                        labelText: " Nome",
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 25,
                                        )),
                                    validator: (value) => isNotEmpty(value, "Preencha o campo Nome"),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: TextFormField(
                                    onSaved: (value) {
                                      _user.SobrenomeConjuge = value.toString();
                                    },
                                    style: const TextStyle(
                                        color: Colors.blueAccent),
                                    decoration: const InputDecoration(
                                        labelText: " Sobrenome",
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 25,
                                        )),
                                    validator: (value) => isNotEmpty(value, "Preencha o campo Sobrenome"),
                                  ),
                                ),
                              )
                            ]),
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: TextFormField(
                                onSaved: (value) {
                                  _user.CPFConjuge = value.toString();
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CpfInputFormatter(),
                                ],
                                keyboardType: TextInputType.number,
                                style:
                                    const TextStyle(color: Colors.blueAccent),
                                decoration: const InputDecoration(
                                    labelText: " CPF",
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25,
                                    )),
                                validator: (value) {
                                  if(value == null || value.isEmpty){
                                    return Validador()
                                        .add(Validar.CPF, msg: 'CPF Inválido')
                                        .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                                        .minLength(11)
                                        .maxLength(11)
                                        .valido(value,clearNoNumber: true);
                                  }
                                },
                              ),
                            ),
                          ]),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      SizedBox(
                        child: ElevatedButton(style: ButtonStyle(alignment: Alignment.centerRight),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.pushNamed(context, '/cadastro_basico');
                            }
                          },
                          child: Text(
                            "Voltar".toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                        SizedBox(
                          child: ElevatedButton(style: ButtonStyle(alignment: Alignment.centerLeft),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Navigator.pushNamed(context, '/Dados_enviados');
                              }
                            },
                            child: Text(
                              "Enviar".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ],
                  ),
                ]))));
  }
}
