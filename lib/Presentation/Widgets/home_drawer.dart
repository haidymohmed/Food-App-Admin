import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Constants/route_id.dart';
import '../../Constants/userInfo.dart';
import '../../Domain/DarkTheme.dart';
import '../../Language/locale_keys.g.dart';
class HomeDrawer extends StatefulWidget {
  static String id = "HomeDrawer";
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  HomeDrawer({Key? key , required this.drawerKey}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}
class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20,
              bottom: 20
          ),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(profilePic),
                      )
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "${customerData.name}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.grey.shade300,
                  ),
                  getRow((){
                    widget.drawerKey.currentState?.openEndDrawer();
                  } , LocaleKeys.home.tr() , Icons.home),
                  getRow((){
                  } , "View Orders", Icons.view_comfy),
                  //MyOrders
                  getRow((){
                    Navigator.pushNamed(context, addProduct);
                  } , "Add Product", Icons.add_circle_rounded),
                  getRow((){
                    Navigator.pushNamed(context, addCategory);
                  } , "Add Category" , Icons.view_comfy ),
                  getRow((){
                    Navigator.pushNamed(context, viewCategory);
                  } , "View Categories" , Icons.view_comfy ),
                  //FeedBack
                  getRow((){
                    Navigator.pushNamed(context, viewProduct);
                  } , "View Products" , Icons.view_comfy),
                  //shareThisApp
                  getRow((){
                  } , "Add Admin" , Icons.add_circle_rounded),
                  getRow((){

                  }, "Dark Mood", null)
                ],
              ),
            ],
          ),
        )
    );
  }
  getRow(method , var title , var icon){
    return
      InkWell(
        onTap: method,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.sp
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.sp
                    ),
                    child: Icon(
                      icon,
                      color: Colors.green,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18
                        )
                    ),
                  ),
                  Spacer(),
                  icon == null ?
                  Switch(onChanged: (bool value) {
                    Provider.of<UserDarkTheme>(context , listen: false).changeTheme();
                  }, value: Provider.of<UserDarkTheme>(context).isDark) :
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: green,
                  )
                ],
              ),
            ),
            Divider(height: 3.sp)
          ],
        )
      );
  }
}
