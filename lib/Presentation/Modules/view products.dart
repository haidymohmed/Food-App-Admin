import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_admin/Constants/CustomerTheme.dart';
import 'package:restaurant_admin/Data/Models/product.dart';
import 'package:restaurant_admin/Domain/AsyncCall.dart';
import 'package:restaurant_admin/Domain/DarkTheme.dart';
import 'package:restaurant_admin/Data/API/category_contraller.dart';
import 'package:restaurant_admin/Data/API/product_contraller.dart';
import 'package:restaurant_admin/Presentation/Widgets/custom_appbar.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/colors.dart';
import '../../Data/Models/category.dart';
import '../../Data/Models/product.dart';
import '../../Data/Models/product.dart';

class ViewProducts extends StatefulWidget {
  ViewProducts({Key? key}) : super(key: key);
  @override
  _ViewProductsState createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {

  late List<Product> products = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              getAppBar(
                  context: context,
                  perffix: const BackButton(),
                  suffix: Container(width: 35.sp,),
                  title: "Products"
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                  stream: ProductContraller.getProducts(),
                  builder: (context,snapShot) {
                    if(snapShot.hasData){
                      print("Start");
                      products.clear();
                      snapShot.data!.docs.forEach((product) {
                        products.add(Product.fromJason(product.data()));
                      });
                      return ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context , index){
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: Provider.of<UserDarkTheme>(context).isDark ? Colors.grey.shade800 : white,
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.sp,
                                    vertical: 5.sp
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: LayoutBuilder(
                                          builder: (context, constraints) => Image.network(
                                            products[index].image,
                                            fit: BoxFit.fill,
                                            width: constraints.maxWidth,
                                            height: constraints.maxHeight,
                                          )
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.sp),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              " " + products[index].nameEn.toString(),
                                              style: UserTheme.get(
                                                  context: context,
                                                  fontSize: 15.sp,
                                                  fontWight: FontWeight.w600,
                                                  colorBright: Colors.grey.shade800,
                                                  colorDark:  Colors.grey.shade300
                                              ),
                                            ),
                                            Text(
                                              " Category ID : " + products[index].id.toString(),
                                              style: UserTheme.get(
                                                  context: context,
                                                  fontSize: 15.sp,
                                                  fontWight: FontWeight.w600,
                                                  colorBright: Colors.grey.shade700,
                                                  colorDark:  Colors.grey.shade300
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                        );
                    }
                    else {
                      return const Center(
                        child: Text(
                          "There are no products yet",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      );
                    }
                  }
                )
              )
            ]
          )
        )
    );
  }
}
