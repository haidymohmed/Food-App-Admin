import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restaurant_admin/Constants/CustomerTheme.dart';
import 'package:restaurant_admin/Data/Models/category.dart';
import 'package:restaurant_admin/Domain/AsyncCall.dart';
import 'package:restaurant_admin/Domain/UpladImage/image_cubit.dart';
import 'package:restaurant_admin/Presentation/Widgets/customer_button.dart';
import 'package:restaurant_admin/Presentation/Widgets/customer_textField.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/colors.dart';
import '../../Data/API/category_contraller.dart';
import '../Dialogs/AppToast.dart';
import '../Widgets/custom_appbar.dart';
class AddCategory extends StatefulWidget {
  AddCategory({Key? key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  CategoryAPI dbHepler = CategoryAPI();
  bool dismiss = false;
  Color pickerColor = Colors.grey;
  Category category = Category(
    name: {
      "en" : "",
      "ar" : ""
    },
    image: "",
    id: "" ,
    color: Colors.green ,
    date: DateTime(DateTime.now().year , DateTime.now().month , DateTime.now().day)
  );
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<AsyncCall>(context).inAsyncCall,
          progressIndicator: SpinKitFadingCircle(
            color: green,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                getAppBar(
                  context: context,
                  title: "Add Category",
                  perffix: BackButton(),
                  suffix: Container(width: 30,),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return SimpleDialog(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment : MainAxisAlignment.spaceAround,
                                    children: [
                                      SimpleDialogOption(
                                        onPressed: ()async{
                                          await ImageCubit.get(context).pickFromGallery();
                                          Navigator.of(context).pop(context);
                                        },
                                        child: Column(
                                            children : [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: Icon(Icons.photo, color: grey,size: 30.sp,),
                                              ),
                                              Text("Open Gallery")
                                            ]
                                        ),
                                      ),
                                      SimpleDialogOption(
                                        onPressed: ()async{
                                          await ImageCubit.get(context).pickFromCamera();
                                          Navigator.of(context).pop(context);
                                        },
                                        child: Column(
                                            children :[
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: Icon(Icons.camera_alt, color: grey,size: 30.sp,),
                                              ),
                                              Text("Open Camera")
                                            ]
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: grey , width: 1.5)
                      ),
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width,
                      child: ImageCubit.get(context).pickedImage == null ?
                      Center(child: Icon(Icons.add_a_photo , color: grey,size: 40.sp,)) :
                      Image.file(ImageCubit.get(context).pickedImage! , fit: BoxFit.cover,),
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomerTextField(
                        hint: "Enter Category Id ",
                        scure: false,
                        suffixIcon: false,
                        isPhone: false,
                        reedOnly: false,
                        onSaved: (v){
                          setState(() {
                            category.id = v.toString();
                          });
                        },
                        validator: (v){
                          if(v.toString().isEmpty){
                            return "Required";
                          }
                        },
                      ),
                      CustomerTextField(
                        hint: "Enter Category Name Arabic ",
                        scure: false,
                        suffixIcon: false,
                        isPhone: false,
                        reedOnly: false,
                        onSaved: (v){
                          setState(() {
                            category.name["ar"] = v.toString();
                          });
                        },
                        validator: (v){
                          if(v.toString().isEmpty){
                            return "Required";
                          }
                        },
                      ),
                      CustomerTextField(
                        hint: "Enter Category Name English ",
                        scure: false,
                        suffixIcon: false,
                        isPhone: false,
                        reedOnly: false,
                        onSaved: (v){
                          setState(() {
                            category.name["en"] = v.toString();
                          });
                        },
                        validator: (v){
                          if(v.toString().isEmpty){
                            return "Required";
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.sp,),
                InkWell(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return  WillPopScope(
                            onWillPop: () async => dismiss,
                            child: AlertDialog(
                              title: const Text('Pick a background color '),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: (v){
                                    pickerColor = v;
                                  },
                                ),
                              ),
                              actions: <Widget>[
                                InkWell(
                                  onTap: (){
                                    Navigator.of(builder).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.sp),
                                    child: Text(
                                      "Close",
                                      style: UserTheme.get(
                                        context: context,
                                        fontWight: FontWeight.w600,
                                        fontSize: 15.sp,
                                        colorBright: Colors.grey,
                                        colorDark: grey
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      category.color = pickerColor;
                                    });
                                    Navigator.of(builder).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.sp),
                                    child: Text(
                                      "Got It",
                                      style: UserTheme.get(
                                          context: context,
                                          fontWight: FontWeight.w600,
                                          fontSize: 15.sp,
                                          colorBright: green,
                                          colorDark: green
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.sp),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Tap to pick a color",
                            style: UserTheme.get(
                              context: context,
                              fontSize: 15.sp,
                              fontWight: FontWeight.w600,
                              colorBright: black,
                              colorDark: white
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: category.color,
                              borderRadius: BorderRadius.circular(5.sp)
                            ),
                            child: Text(""),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                UserButton(
                  title: " Add ",
                  color: green,
                  method: () async{
                    Provider.of<AsyncCall>(context , listen: false).changeAsyncCall(true);
                    if(formKey.currentState!.validate()){
                      try{
                        formKey.currentState!.save();
                        await ImageCubit.get(context).uploadImageToFirebase(category.id , category);
                        await dbHepler.addCategory(category);
                      }catch(error){
                        showToastError(msg: error.toString(), state: ToastedStates.ERROR);
                      }
                    }
                    Provider.of<AsyncCall>(context , listen: false).changeAsyncCall(false);

                    category = Category(
                        name: {
                          "en" : "",
                          "ar" : ""
                        },
                        image: "",
                        id: "" ,
                        color: Colors.green ,
                        date: DateTime(DateTime.now().year , DateTime.now().month , DateTime.now().day)
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
