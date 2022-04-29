import 'package:flutter/material.dart';
import 'package:restaurant_admin/Presentation/Modules/add_category.dart';
import 'package:restaurant_admin/Presentation/Modules/add_product.dart';
import 'package:restaurant_admin/Presentation/Modules/view%20products.dart';
import 'Constants/route_id.dart';
import 'Presentation/Modules/forgetPassword.dart';
import 'Presentation/Modules/home.dart';
import 'Presentation/Modules/log_in.dart';
import 'Presentation/Modules/sendLoginLink.dart';
import 'Presentation/Modules/view_categories.dart';

class AppRoute{
  static Route onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case homePath:
        return navigateTo(const Home());
      case viewCategory :
        return navigateTo(const ViewCategories());
      case addCategory:
        return navigateTo( AddCategory());
      case addProduct :
        return navigateTo(const AddProduct());
      case logInPath:
        return navigateTo(const LogIn());
      case viewProduct :
        return navigateTo(ViewProducts());
      case sendEmailLinkPath:
        return navigateTo(const SendLoginLink());
      case forgetPassPath:
        return navigateTo(const ForgetPassword());
      default:
        return navigateTo(Home());
    }
  }
  static navigateTo(destination){
    return MaterialPageRoute(builder: (context) => destination);
  }
}