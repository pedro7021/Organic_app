import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organic/services/backend_manager.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validadores/Validador.dart';

import '../../components/button.dart';
import '../../components/custom_dropdown.dart';
import '../../components/custom_text_field.dart';
import '../../models/ad.dart';
import '../../models/brute_app_data.dart';
import '../../services/user_manager.dart';
import 'components/images_form.dart';

class CreateAdScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BackendManager backendManager = BackendManager();
  final List<File> _photosList = [];

  Ad _ad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Anúncio"),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImagesForm(onSaved: (photos) {
                  for (final File photo in photos as List<File>) {
                    _photosList.add(photo);
                  }
                }),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "Título",
                  hintText: "Digite o título do anúncio",
                  onSaved: (title) => _ad.title = title,
                  maxLength: 50,
                  validator: (text) {
                    return Validador()
                        .add(Validar.OBRIGATORIO, msg: "Campo Obrigatório")
                        .valido(text);
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "Descrição",
                  hintText: "Descrição do anúncio",
                  onSaved: (description) => _ad.description = description,
                  maxLength: 1000,
                  validator: (text) {
                    return Validador()
                        .add(Validar.OBRIGATORIO, msg: "Campo Obrigatório")
                        .valido(text);
                  },
                ),
                const SizedBox(height: 16),
                CustomDropdown(
                  title: "Categoria",
                  hintText: "Escolha uma Categoria",
                  items: CategoriesItems(),
                  onSaved: (category) {
                    _ad.category = category as String;
                  },
                  validator: (value) {
                    if (value != " ") {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo Obrigatório")
                          .valido(value as String);
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        title: "Preço",
                        hintText: "Preço",
                        onSaved: (price) {
                          price = price
                              .replaceAll(".", "")
                              .replaceAll(",", ".")
                              .replaceAll(" ", "")
                              .replaceAll("R", "")
                              .replaceAll("\$", "");
                          _ad.price = double.parse(price);
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          RealInputFormatter(
                            centavos: true,
                            moeda: true,
                          ),
                        ],
                        validator: (text) {
                          return Validador()
                              .add(Validar.OBRIGATORIO,
                                  msg: "Campo Obrigatório")
                              .valido(text);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: CustomDropdown(
                        title: "Medida",
                        hintText: "Medida",
                        items: MeasureItems(),
                        onSaved: (measure) {
                          _ad.measure = measure as String;
                        },
                        validator: (value) {
                          if (value != " ") {
                            return Validador()
                                .add(Validar.OBRIGATORIO,
                                    msg: "Campo Obrigatório")
                                .valido(value as String);
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  title: "Telefone",
                  hintText: "Número de telefone para contato",
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  validator: (text) {
                    text = text
                        .replaceAll("(", "")
                        .replaceAll(")", "")
                        .replaceAll(" ", "")
                        .replaceAll("-", "");
                    return Validador()
                        .add(Validar.OBRIGATORIO, msg: "Campo Obrigatório")
                        .minLength(10, msg: "Número de Telefone Inválido")
                        .valido(text);
                  },
                  onSaved: (phone) {
                    phone = phone
                        .replaceAll("(", "")
                        .replaceAll(")", "")
                        .replaceAll(" ", "")
                        .replaceAll("-", "");

                    _ad.phone = int.parse(phone);
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  "Atenção: Seu número de telefone estará disponível para todos que visualizarem seu anúncio.",
                ),
                const SizedBox(height: 16),
                Card(
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  margin: const EdgeInsets.all(16),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "O seu anúncio após publicado será exibido para pessoas até 15 quilômetros da sua localização atual",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<UserManager>(
                  builder: (_, userManager, __) {
                    return SizedBox(
                      width: double.infinity,
                      child: Button(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              // TODO create ad
                              _ad = Ad();

                              formKey.currentState.save();
                              backendManager.SaveAd(
                                token: userManager.user.token,
                                context: context,
                                ad: _ad,
                                images: _photosList,
                              );
                            }
                          },
                          text: "Publicar Anúncio"),
                    );
                  },
                ),
                const SizedBox(height: 16),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Ao publicar você concorda e aceita nossos ",
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: "Termos e Condições",
                              style: const TextStyle(color: Colors.blueAccent),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launch(
                                    "https://organic.app.br/legal/terms/")),
                          const TextSpan(
                            text: " e ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                              text: "Privacidade",
                              style: const TextStyle(color: Colors.blueAccent),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launch(
                                    "https://organic.app.br/legal/privacy-policy/")),
                        ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
