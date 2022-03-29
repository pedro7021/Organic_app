import 'package:flutter/material.dart';
import 'package:organic/services/backend_manager.dart';
import 'package:validadores/Validador.dart';

import '../../components/list_item_ad.dart';
import '../../models/ad.dart';
import '../../models/denounce.dart';

class DenounceScreen extends StatelessWidget {
  Denounce _denounce;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> denounceItens = [
    {
      "title": "Preço enganoso ou errado",
      "subtitle":
          "O preço do produto está fora da realidade ou não corresponde a uma parcela do seu valor total",
      "index": 0,
    },
    {
      "title": "Propaganda indevida ou brincadeira",
      "subtitle":
          "Anunciante oferece um produto ou serviço inexistente, faz propaganda indevida ou utiliza o site para brincadeiras",
      "index": 1,
    },
    {
      "title": "Categoria incorreta",
      "subtitle": "O anúncio não deveria estar nessa categoria",
      "index": 2,
    },
    {
      "title": "Anúncio duplicado",
      "subtitle": "Existem um ou mais anúncios iguais a este",
      "index": 3,
    },
    {
      "title": "Produto/serviço proibido, ilegal ou ofensivo",
      "subtitle":
          "Conteúdo que viola as leis ou é proibido pelas regras do Organic",
      "index": 4,
    },
    {
      "title": "Suspeita de golpe ou fraude",
      "subtitle": "Anunciante tem atitude suspeita",
      "index": 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Ad ad = ModalRoute.of(context).settings.arguments as Ad;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Denunciar"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListItemAd(
                ad: ad,
                disableClick: true,
              ),
              const SizedBox(height: 16),
              const Text(
                "Qual o problema deste anúncio?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              FormField<int>(
                  onSaved: (value) {
                    _denounce.topic = denounceItens[value]["title"] as String;
                  },
                  initialValue: 10,
                  validator: (value) {
                    if (value == 10) {
                      return "Escolha um Problema";
                    } else {
                      return null;
                    }
                  },
                  builder: (state) {
                    return Column(children: [
                      ...denounceItens.map(
                        (item) => ListTile(
                          minVerticalPadding: 16,
                          leading: Radio(
                              activeColor: Theme.of(context).primaryColor,
                              value: item["index"] as int,
                              groupValue: state.value,
                              onChanged: (int value) {
                                // ignore: invalid_use_of_protected_member
                                state.setValue(value);
                                state.didChange(state.value);
                              }),
                          title: Transform(
                              transform:
                                  Matrix4.translationValues(-16, 0.0, 0.0),
                              child: Text(item["title"] as String)),
                          subtitle: Transform(
                              transform:
                                  Matrix4.translationValues(-16, 0.0, 0.0),
                              child: Text(item["subtitle"] as String)),
                        ),
                      ),
                      if (state.hasError)
                        Container(
                          margin: const EdgeInsets.only(top: 16, left: 16),
                          alignment: Alignment.centerLeft,
                          child: Text("[${state.errorText}]",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              )),
                        )
                    ]);
                  }),
              const Text(
                "Email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email (opcional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  onSaved: (email) => _denounce.email = email,
                  validator: (email) {
                    if (email != "") {
                      return Validador()
                          .add(Validar.EMAIL, msg: "E-mail inválido")
                          .valido(email);
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              const Text(
                "Descrição",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Descreva o problema",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onSaved: (description) => _denounce.description = description,
                maxLength: 500,
                validator: (text) {
                  return Validador()
                      .add(Validar.OBRIGATORIO, msg: "Campo Obrigatório")
                      .valido(text);
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                  ),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      _denounce = Denounce();
                      formKey.currentState.save();
                      _denounce.adId = ad.id;
                      BackendManager().SendDenounce(
                        context: context,
                        denounce: _denounce,
                      );
                    }
                  },
                  child: const Text(
                    "Enviar Denúncia",
                    style: TextStyle(fontSize: 18),
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
