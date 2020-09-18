import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/modals/product.dart';

class Store {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  addProduct(Product product){
    _fireStore.collection(productCollection).add({
      pName : product.pName,
      pPrice : product.pPrice,
      pDescription : product.pDescription,
      pLocation : product.pLocation,
      pCategory : product.pCategory
    });
  }

  Stream <QuerySnapshot>loadProducts () {

    return _fireStore.collection(productCollection)
        .snapshots();
  }

  deleteProduct(documentId){
    _fireStore.collection(productCollection).doc(documentId).delete();
  }

  editProduct(data, docId){
    _fireStore.collection(productCollection).doc(docId).update(data);
  }

  storeOrders(data, List<Product> products){
    var documentRef = _fireStore.collection(orders).doc();
    documentRef.set(data);
    for (var product in products){
      documentRef.collection(orderDetails).doc().set({
        pName: product.pName,
        pPrice: product.pPrice,
        quantity: product.quantity,
        pLocation: product.pLocation,
        pCategory: product.pCategory
      });
    }

  }

  Stream <QuerySnapshot>loadOrders(){
    return _fireStore.collection(orders).snapshots();
  }

  Stream <QuerySnapshot>loadOrderDetails(documentId){
    return _fireStore.collection(orders).doc(documentId).collection(orderDetails).snapshots();
  }
}



