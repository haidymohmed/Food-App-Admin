import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_admin/Data/Models/category.dart';
import 'package:restaurant_admin/Domain/UpladImage/image_status.dart';
import 'dart:io';

class ImageCubit extends Cubit<ImageStatus>{
  File? pickedImage ;
  static ImageCubit get(context) => BlocProvider.of(context);
  ImageCubit() : super(LoadingImage());
  pickFromCamera()async{
    try{
      var image = await ImagePicker().pickImage(source: ImageSource.camera);
      pickedImage = File(image!.path);
      emit(PickedImageSuccess());
    }catch(e){
      emit(PickedImageFailed());
    }
  }
  pickFromGallery()async{
    try{
      var image  = await ImagePicker().pickImage(source: ImageSource.gallery);
      pickedImage = File(image!.path);
      emit(PickedImageSuccess());
    }catch(e){
      emit(PickedImageFailed());
    }
  }
  uploadImageToFirebase(var id , model)async{
    try{
      FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(bucket: 'gs://foodizone-f7d69.appspot.com');
      Reference reference = firebaseStorage.ref().child('ProductsImage').child(id);
      await reference.putFile(pickedImage!).whenComplete(() => null);
      String url = await reference.getDownloadURL();
      model.image = url.toString();
      emit(UploadImageSuccess());
    }catch(e){
      emit(UploadImageFailed());
    }
  }
}