import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_admin/Data/Models/category.dart';
import 'package:restaurant_admin/Presentation/Dialogs/AppToast.dart';

class CategoryAPI{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  addCategory(Category category)async{
    await firebaseFirestore.collection("Categories").doc(category.id).set(category.toJson()).then((value){
      showToastError(msg: "Added Succeeded", state: ToastedStates.SUCCESS);
    }).onError((error, stackTrace) {
      showToastError(msg: error.toString(), state: ToastedStates.ERROR);
    });
  }
  getCategories(){
    return firebaseFirestore.collection("Categories").snapshots();
  }

  getCategoriesId(){
    List<Map<String , String>> list = [];
    firebaseFirestore.collection("Categories").snapshots().map((event){
      event.docs.forEach((element) {
        list.add({
          "id" : element.id,
          "name" : element.get('name_en')
        });
      });
    });
    return list;
  }
}