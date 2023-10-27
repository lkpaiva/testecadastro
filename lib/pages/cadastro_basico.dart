import 'package:brasil_fields/brasil_fields.dart';
import 'package:cadastro/mixin/validations_mixin.dart';
import 'package:cadastro/pages/CadastroEnderecoEstadoCivil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validadores/Validador.dart';
import '../models/users.dart';

class CadastroBasico extends StatefulWidget {
  const CadastroBasico({super.key});

  @override
  State<CadastroBasico> createState() => _CadastroBasicoState();
}

class _CadastroBasicoState extends State<CadastroBasico> with ValidationsMixin{
  final _formKey = GlobalKey<FormState>();
  final User _user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 30.0),
            child: Form(
              key: _formKey,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(children: <Widget>[
                      Image.asset(
                        'Assets/images/logo_ademicon.png',
                        width: 150,
                        height: 150,
                      ),
                      Divider(),
                      const Text("Cadastro",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                          textAlign: TextAlign.justify),
                      Divider(),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: TextFormField(
                              onSaved: (value) {
                                _user.Nome = value.toString();
                              },
                              style: const TextStyle(color: Colors.blueAccent),
                              decoration: const InputDecoration(
                                  labelText: " Nome",
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
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
                                _user.Sobrenome = value.toString();
                              },
                              style: const TextStyle(color: Colors.blueAccent),
                              decoration: const InputDecoration(
                                  labelText: " Sobrenome",
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
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
                            _user.Email = value.toString();
                          },
                          style: const TextStyle(color: Colors.blueAccent),
                          decoration: const InputDecoration(
                              labelText: " E-mail",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              )),
                          // onSaved: ,
                          validator: (value) => isNotEmpty(value, "O endereço de E-mail é invalido"),
                        ),
                      ),
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
                                  _user.Celular = value.toString();
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  TelefoneInputFormatter(),
                                ],
                                keyboardType: TextInputType.number,
                                style:
                                    const TextStyle(color: Colors.blueAccent),
                                decoration: const InputDecoration(
                                    labelText: " Celular",
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    )),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length == 14) {
                                    return "Endereço de email inválido";
                                  }
                                  return null;
                                },
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
                                  _user.CPF = value.toString();
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
                                      fontSize: 20,
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
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.pushNamed(context, '/CadastroEnderecoEstadoCivil');
                          }
                        },
                        child: Text(
                          "Proxima página".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    ),
                ),
            ),
        ),
    );
  }
}
