// ignore_for_file: avoid_print

import 'package:diyotis_stok/database/database.dart';
import 'package:diyotis_stok/models/resistors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;

class AddComponent extends StatefulWidget {
  const AddComponent({Key? key}) : super(key: key);

  @override
  State<AddComponent> createState() => _AddComponentState();
}

class _AddComponentState extends State<AddComponent> {
  @override
  void initState() {
    super.initState();
    /*  WidgetsBinding.instance.addPostFrameCallback((_) {
      resistors = ModalRoute.of(context)?.settings.arguments as Resistors;
    }); */
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    valueController.dispose();
    quantityController.dispose();
    priceController.dispose();
    typeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Resistors? resistors =
        ModalRoute.of(context)?.settings.arguments as Resistors?;
    var widgetText = 'Add Resistor';
    if (resistors != null) {
      nameController.text = resistors.name;
      valueController.text = resistors.value.toString();
      quantityController.text = resistors.quantity.toString();
      priceController.text = resistors.price.toString();
      typeController.text = resistors.type;
      widgetText = 'Update Resistor';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widgetText),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter(
                        RegExp(r'^\d{1,}\,?\d{0,3}'),
                        allow: true,
                      )
                    ],
                    controller: valueController,
                    decoration: const InputDecoration(labelText: 'Value'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: quantityController,
                    decoration: const InputDecoration(labelText: 'Quantity'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    inputFormatters: [
                      FilteringTextInputFormatter(
                        RegExp(r'^\d{1,}\,?\d{0,3}'),
                        allow: true,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: typeController,
                    decoration: const InputDecoration(labelText: 'Type'),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 4.0),
              child: ElevatedButton(
                child: Text(widgetText),
                onPressed: () {
                  if (resistors != null) {
                    updateComponent(resistors);
                  } else {
                    addComponent(resistors);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addComponent(Resistors? resistors) async {
    final resistors = Resistors(
      m.ObjectId(),
      nameController.text,
      double.parse(valueController.text),
      int.parse(quantityController.text),
      double.parse(priceController.text),
      typeController.text,
    );
    await DiyotisDB.addComponent(resistors);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> updateComponent(Resistors? resistors) async {
    print('updating: ${nameController.text}');
    final resistors = Resistors(
      m.ObjectId(),
      nameController.text,
      double.parse(valueController.text),
      int.parse(quantityController.text),
      double.parse(priceController.text),
      typeController.text,
    );
    await DiyotisDB.updateComponent(resistors);
    if (!mounted) return;
    Navigator.pop(context);
  }
}
