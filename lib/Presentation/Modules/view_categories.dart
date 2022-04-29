import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_admin/Constants/CustomerTheme.dart';
import 'package:restaurant_admin/Domain/DarkTheme.dart';
import 'package:restaurant_admin/Data/API/category_contraller.dart';
import 'package:restaurant_admin/Presentation/Widgets/custom_appbar.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/colors.dart';
import '../../Data/Models/category.dart';
import 'package:easy_localization/easy_localization.dart';
class ViewCategories extends StatefulWidget {
  const ViewCategories({Key? key}) : super(key: key);

  @override
  _ViewCategoriesState createState() => _ViewCategoriesState();
}

class _ViewCategoriesState extends State<ViewCategories> {
  CategoryAPI categoryAPI = CategoryAPI();
  List<Category> categories = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: categoryAPI.getCategories(),
      builder: (context, snapShot) {
          categories.clear();
          if(snapShot.hasData){
            snapShot.data?.docs.forEach((data) {
              print(data.get('date').toDate().toString());
              categories.add(Category(
                name: {
                  "en" :  data.get('name_en'),
                  "ar" :  data.get('name_ar'),
                },
                color: Color(int.parse(data.get('color').split('(0x')[1].split(')')[0], radix: 16)),
                id: data.get('id'),
                image: data.get('image'),
                date: data.get('date').toDate()
              ));
              }
            );
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
                    Expanded(child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context , index){
                          return InkWell(
                            onTap: (){
                            },
                            child: Container(
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
                                          categories[index].image,
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                categories[index].name[context.locale.toString()].toString(),
                                                style: UserTheme.get(
                                                    context: context,
                                                    fontSize: 15.sp,
                                                    fontWight: FontWeight.w600,
                                                    colorBright: Colors.grey.shade700,
                                                    colorDark:  Colors.grey.shade300
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 15.sp,
                                                    height: 15.sp,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10.sp),
                                                      color: categories[index].color,
                                                    ),
                                                    child: Text(""),
                                                  ),
                                                  InkWell(
                                                    onTap: (){

                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "ID : " + categories[index].id,
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
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                    ))
                  ],
                ),
              ),
            );
          }
          else{
            return Container(
              child: Text("No Data"),
            );
          }
        }
    );
  }
}
