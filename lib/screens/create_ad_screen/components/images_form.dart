import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  final Function(List<dynamic>) onSaved;

  const ImagesForm({this.onSaved});

  @override
  Widget build(BuildContext context) {
    return FormField<List<File>>(
        onSaved: onSaved,
        initialValue: List.from([]),
        validator: (images) {
          if (images.isEmpty) {
            return "Insira ao menos uma imagem";
          } else {
            return null;
          }
        },
        builder: (state) {
          void onImageSelected(File file) {
            state.value.add(file);
            state.didChange(state.value);
            Navigator.of(context).pop();
          }

          return Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  dotSize: 4,
                  dotSpacing: 15,
                  dotBgColor: Colors.transparent,
                  dotColor: Theme.of(context).primaryColor,
                  autoplay: false,
                  images: state.value.map<Widget>((imagem) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(
                          imagem,
                          //fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              state.value.remove(imagem);
                              state.didChange(state.value);
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList()
                    ..add(
                      Material(
                        color: Colors.grey[100],
                        child: IconButton(
                          icon: const Icon(Icons.add_a_photo),
                          color: Theme.of(context).primaryColor,
                          iconSize: 50,
                          onPressed: () {
                            if (Platform.isAndroid) {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => ImageSourceSheet(
                                  onImageSelected: onImageSelected,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
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
                ),
            ],
          );
        });
  }
}
