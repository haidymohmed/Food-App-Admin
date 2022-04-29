import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_admin/Data/Models/category.dart';
import 'package:restaurant_admin/Data/Models/product.dart';
import '../../Presentation/Dialogs/AppToast.dart';


class ProductContraller{
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static late List<Category> categories ;
  static addProduct(Product product)async{
    await firebaseFirestore.collection("Products").doc(product.id).set(product.toJson()).then((value){
      showToastError(msg: "Added Succeeded", state: ToastedStates.SUCCESS);
    }).onError((error, stackTrace) {
      showToastError(msg: error.toString(), state: ToastedStates.ERROR);
    });
  }
  static getProducts(){
    return firebaseFirestore.collection("Products").snapshots();
  }
}