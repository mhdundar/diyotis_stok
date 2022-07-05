// ignore_for_file: avoid_print

import 'package:diyotis_stok/models/resistors.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DiyotisDB {
  static late Db db;
  static late DbCollection collection;

  static Future<void> connectDB() async {
    db = await Db.create(
      'mongodb+srv://mhdundar:123@cluster0.sawtu.mongodb.net/diyotisDB',
    );
    collection = db.collection('Resistors');
    await db.open();
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {
    try {
      final resistors = await collection.find().toList();
      return resistors;
    } catch (e) {
      print(e);
      throw Future.value(e);
    }
  }

  static Future<void> addComponent(Resistors? resistors) async {
    await collection.insertOne(resistors!.toMap());
  }

  static Future<void> updateComponent(Resistors? resistors) async {
    await collection.updateOne(resistors?.id, resistors?.toMap());
  }

  static Future<void> delete(Resistors? resistors) async {
    await collection.remove(where.id(resistors!.id));
  }
}
