import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:coffee_shop/data/models/universal_data.dart';

class CoffeeRepo {
  String firebaseCollection = "coffeeCollection";
  Future<UniversalData> addCoffee({required CoffeeModel coffeeModel}) async {
    try {
      DocumentReference newCoffee = await FirebaseFirestore.instance
          .collection(firebaseCollection)
          .add(coffeeModel.toMap());

      await FirebaseFirestore.instance
          .collection(firebaseCollection)
          .doc(newCoffee.id)
          .update({
        "coffeeId": newCoffee.id,
      });

      return UniversalData(data: "Coffee added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateCoffee({required CoffeeModel coffeeModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection(firebaseCollection)
          .doc(coffeeModel.coffeeId)
          .update(coffeeModel.toMap());

      return UniversalData(data: "Coffee updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> deleteCoffee({required String coffeeId}) async {
    try {
      await FirebaseFirestore.instance
          .collection(firebaseCollection)
          .doc(coffeeId)
          .delete();

      return UniversalData(data: "Coffee deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Stream<List<CoffeeModel>> getProducts() =>
      FirebaseFirestore.instance.collection(firebaseCollection).snapshots().map(
            (event1) => event1.docs
                .map((doc) => CoffeeModel.fromMap(doc.data()))
                .toList(),
          );

  Stream<List<CoffeeModel>> searchProducts(String searchString) {
    return FirebaseFirestore.instance
        .collection(firebaseCollection)
        .where('name', isGreaterThanOrEqualTo: searchString)
        .where('name', isLessThan: searchString + 'z')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => CoffeeModel.fromMap(doc.data()))
          .toList();
    });
  }
}
