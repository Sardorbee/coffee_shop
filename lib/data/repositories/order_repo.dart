import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:coffee_shop/data/models/order_model.dart';
import 'package:coffee_shop/data/models/universal_data.dart';

class OrderRepo {
  String orderCollection = "orderCollection";
  Future<UniversalData> addOrder({required OrderModel coffeeModel}) async {
    try {
      DocumentReference newCoffee = await FirebaseFirestore.instance
          .collection(orderCollection)
          .add(coffeeModel.toJson());

      await FirebaseFirestore.instance
          .collection(orderCollection)
          .doc(newCoffee.id)
          .update({
        "orderId": newCoffee.id,
      });

      return UniversalData(data: "Order added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateOrder({required OrderModel coffeeModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection(orderCollection)
          .doc(coffeeModel.orderId)
          .update(coffeeModel.toJson());

      return UniversalData(data: "Order updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> deleteOrder({required String coffeeId}) async {
    try {
      await FirebaseFirestore.instance
          .collection(orderCollection)
          .doc(coffeeId)
          .delete();

      return UniversalData(data: "Order deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Stream<List<OrderModel>> getOrders() =>
      FirebaseFirestore.instance.collection(orderCollection).snapshots().map(
            (event1) => event1.docs
                .map((doc) => OrderModel.fromJson(doc.data()))
                .toList(),
          );
}
