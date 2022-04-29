import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_admin/Constants/CustomerTheme.dart';
import 'package:restaurant_admin/Data/API/product_contraller.dart';
import 'package:restaurant_admin/Domain/ChangeLanguage/language_cubit.dart';
import 'package:restaurant_admin/Domain/DarkTheme.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/colors.dart';
import '../../Data/Models/product.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/UpladImage/image_cubit.dart';
import '../../Data/API/category_contraller.dart';
import '../Dialogs/AppToast.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/customer_button.dart';
import '../Widgets/customer_textField.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Product product = Product(
      id: '',
      nameAr: '',
      nameEn: '',
      descriptionEn:  "",
      descriptionAr: '',
      category: '',
      quantity: 1,
      fat: 0,
      cale: 0,
      protein: 0,
      needPasta: true,
      needSalad: true,
      needRise: true,
      carb: 0,
      needPotatoes: true,
      price: 0,
      image: '',
      rate: 0,
      date: DateTime(DateTime.now().year , DateTime.now().month , DateTime.now().day)
  );
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int selected = 0;
  CategoryAPI categoryAPI = CategoryAPI();
  List<Map<String , String>> categories = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: categoryAPI.getCategories(),
        builder: (context, snapShot) {
          categories.clear();
          if (snapShot.hasData) {
            snapShot.data?.docs.forEach((data) {
              categories.add({
                "id" : data.id,
                "name" : data.get("name_en")
              });
            });
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
                          title: "Add Proudect",
                          perffix: BackButton(),
                          suffix: Container(
                            width: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SimpleDialogOption(
                                                onPressed: () async {
                                                  await ImageCubit.get(context)
                                                      .pickFromGallery();
                                                  Navigator.of(context)
                                                      .pop(context);
                                                },
                                                child: Column(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Icon(
                                                      Icons.photo,
                                                      color: grey,
                                                      size: 30.sp,
                                                    ),
                                                  ),
                                                  Text("Open Gallery")
                                                ]),
                                              ),
                                              SimpleDialogOption(
                                                onPressed: () async {
                                                  await ImageCubit.get(context)
                                                      .pickFromCamera();
                                                  Navigator.of(context)
                                                      .pop(context);
                                                },
                                                child: Column(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      color: grey,
                                                      size: 30.sp,
                                                    ),
                                                  ),
                                                  const Text("Open Camera")
                                                ]),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: grey, width: 1.5)),
                              height: MediaQuery.of(context).size.height * .3,
                              width: MediaQuery.of(context).size.width,
                              child: ImageCubit.get(context).pickedImage == null
                                  ? Center(
                                      child: Icon(
                                      Icons.add_a_photo,
                                      color: grey,
                                      size: 40.sp,
                                    ))
                                  : Image.file(
                                      ImageCubit.get(context).pickedImage!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomerTextField(
                                hint: "Enter Product Id ",
                                scure: false,
                                suffixIcon: false,
                                isPhone: false,
                                reedOnly: false,
                                onSaved: (v) {
                                  setState(() {
                                    product.id = v.toString();
                                  });
                                },
                                validator: (v) {
                                  if (v.toString().isEmpty) {
                                    return "Required";
                                  }
                                },
                              ),
                              CustomerTextField(
                                hint: "Enter Product Name Arabic",
                                scure: false,
                                suffixIcon: false,
                                isPhone: false,
                                reedOnly: false,
                                onSaved: (v) {
                                  setState(() {
                                    product.nameAr = v.toString();
                                  });
                                },
                                validator: (v) {
                                  if (v.toString().isEmpty) {
                                    return "Required";
                                  }
                                },
                              ),
                              CustomerTextField(
                                hint: "Enter Product Name English",
                                scure: false,
                                suffixIcon: false,
                                isPhone: false,
                                reedOnly: false,
                                onSaved: (v) {
                                  setState(() {
                                    product.nameEn = v.toString();
                                  });
                                },
                                validator: (v) {
                                  if (v.toString().isEmpty) {
                                    return "Required";
                                  }
                                },
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                margin: EdgeInsets.symmetric(vertical: 5.sp),
                                decoration: BoxDecoration(
                                    color: Provider.of<UserDarkTheme>(context)
                                        .isDark
                                        ? Colors.grey.shade800
                                        : background,
                                    borderRadius: BorderRadius.circular(5.sp)
                                ),
                                child: ExpansionTile(
                                  textColor: black,
                                  subtitle: Text(
                                    "Required ",
                                    style: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.bold,
                                      color: grey,
                                    ),
                                  ),
                                  title: Text(
                                    "Categories",
                                    style: GoogleFonts.tajawal(
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold,
                                        color:
                                        Provider.of<UserDarkTheme>(context)
                                            .isDark
                                            ? Colors.grey.shade600
                                            : black)
                                    ,
                                  ),
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        for (int i = 0; i < categories.length; i++)
                                          LayoutBuilder(
                                              builder: (context, constraints) {
                                                return InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      this.selected = i;
                                                    });
                                                    product.category = categories[i]["id"].toString();
                                                  },
                                                  child: Container(
                                                    width: constraints.maxWidth,
                                                    margin: EdgeInsets.symmetric(
                                                      vertical: 2.sp,
                                                      horizontal: 5.sp
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: selected == i ? Colors.grey.shade900 : Colors.grey.shade700,
                                                      borderRadius: BorderRadius.circular(10.sp)
                                                    ),
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 9.sp,
                                                        vertical: 10.sp
                                                    ),
                                                    child: Text(
                                                      categories[i]["name"].toString(),
                                                      style: UserTheme.get(
                                                          context: context,
                                                          fontWight: FontWeight.w600,
                                                          fontSize: 15.sp,
                                                          colorDark: white,
                                                          colorBright: black
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              CustomerTextField(
                                hint: "Enter Product description Arabic",
                                scure: false,
                                suffixIcon: false,
                                isPhone: false,
                                reedOnly: false,
                                onSaved: (v) {
                                  setState(() {
                                    product.descriptionAr = v.toString();
                                  });
                                },
                                validator: (v) {
                                  if (v.toString().isEmpty) {
                                    return "Required";
                                  }
                                },
                              ),
                              CustomerTextField(
                                hint: "Enter Product description English",
                                scure: false,
                                suffixIcon: false,
                                isPhone: false,
                                reedOnly: false,
                                onSaved: (v) {
                                  setState(() {
                                    product.descriptionEn = v.toString();
                                  });
                                },
                                validator: (v) {
                                  if (v.toString().isEmpty) {
                                    return "Required";
                                  }
                                },
                              ),
                              CustomerTextField(
                                hint: "Enter Product calories ",
                                scure: false,
                                suffixIcon: false,
                                isPhone: false,
                                reedOnly: false,
                                onSaved: (v) {
                                  setState(() {
                                    product.cale = double.parse(v.toString());
                                  });
                                },
                                validator: (v) {
                                  if (v.toString().isEmpty) {
                                    return "Required";
                                  }
                                },
                              ),
                              CustomerTextField(
                                hint: "Enter Product protein",
                                scure: false,
                                suffixIcon: false,
                                isPhone: false,
                                reedOnly: false,
                                onSaved: (v) {
                                  setState(() {
                                    product.protein = double.parse(v.toString());
                                  });
                                },
                                validator: (v) {
                                  if (v.toString().isEmpty) {
                                    return "Required";
                                  }
                                },
                              ),
                              CustomerTextField(
                                hint: "Enter Product carbs",
                                scure: false,
                                suffixIcon: false,
                                isPhone: false,
                                reedOnly: false,
                                onSaved: (v) {
                                  setState(() {
                                    product.carb = double.parse(v.toString());
                                  });
                                },
                                validator: (v) {
                                  if (v.toString().isEmpty) {
                                    return "Required";
                                  }
                                },
                              ),
                              CustomerTextField(
                                hint: "Enter Product fat",
                                scure: false,
                                suffixIcon: false,
                                isPhone: false,
                                reedOnly: false,
                                onSaved: (v) {
                                  setState(() {
                                    product.fat = double.parse(v.toString());
                                  });
                                },
                                validator: (v) {
                                  if (v.toString().isEmpty) {
                                    return "Required";
                                  }
                                },
                              ),
                              CustomerTextField(
                                hint: "Enter Product price ",
                                scure: false,
                                suffixIcon: false,
                                isPhone: false,
                                reedOnly: false,
                                onSaved: (v) {
                                  setState(() {
                                    product.price = double.parse(v.toString());
                                  });
                                },
                                validator: (v) {
                                  if (v.toString().isEmpty) {
                                    return "Required";
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        UserButton(
                            title: " Add ",
                            color: green,
                            method: () async {
                              Provider.of<AsyncCall>(context, listen: false)
                                  .changeAsyncCall(true);
                              if (formKey.currentState!.validate()) {
                                try {
                                  formKey.currentState!.save();
                                  await ImageCubit.get(context).uploadImageToFirebase(product.id, product);
                                  await ProductContraller.addProduct(product);
                                  ImageCubit.get(context).pickedImage;
                                } catch (error) {
                                  showToastError(
                                      msg: error.toString(),
                                      state: ToastedStates.ERROR);
                                }
                              //}
                              Provider.of<AsyncCall>(context, listen: false)
                                  .changeAsyncCall(false);
                            }
                            }
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
