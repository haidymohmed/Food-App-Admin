import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_admin/Constants/CustomerTheme.dart';
import 'package:restaurant_admin/Constants/colors.dart';
import 'package:restaurant_admin/Data/Models/SettingModel.dart';
import 'package:restaurant_admin/Domain/DarkTheme.dart';
import 'package:restaurant_admin/Presentation/Modules/add_product.dart';
import 'package:restaurant_admin/Presentation/Widgets/home_drawer.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/route_id.dart';
import '../Widgets/custom_appbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    List<Setting> list = [
      Setting(title: "Add Product", data: Icons.add, action: (){
        Navigator.pushNamed(context, addProduct);
      }),
      Setting(title: "Add Category", data: Icons.add, action: (){
        Navigator.pushNamed(context, addCategory);
      }),
      Setting(title: "Display Product", data: Icons.view_comfy, action: (){
        Navigator.pushNamed(context, viewProduct);
      }),
      Setting(title: "Display Category", data: Icons.view_comfy, action: (){
        Navigator.pushNamed(context, viewCategory);
      }),
    ];
    return Scaffold(
      key: key,
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: HexColor("#98CD3D"),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Container(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: list.length,
            itemBuilder: (context , index){
              return InkWell(
                onTap: (){
                  list[index].action();
                },
                child: Container(
                  margin: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.circular(20.sp)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        list[index].data,
                        size: 50.sp,
                        color:  HexColor("#98CD3D"),
                      ),
                      Text(
                        list[index].title.toString(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
        ),
      )
    );
  }
}
