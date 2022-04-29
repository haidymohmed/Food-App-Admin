import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:sizer/sizer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Constants/route_id.dart';
import '../../Constants/userInfo.dart';
import '../../Data/Models/User.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/Auth/auth_cubit.dart';
import '../../Language/locale_keys.g.dart';
import '../Widgets/customer_button.dart';
import '../Widgets/customer_textField.dart';
import '../Widgets/title_text_field.dart';
class LogIn extends StatefulWidget {
  static String id = "LogIn";
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}
class _LogInState extends State<LogIn> {
  bool inAsyncCall = false ;
  late String email ="", password ="";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var list = [
    GetIcon(color: Colors.red, icon: googleIcon),
    GetIcon(color: Colors.blue.shade500, icon: facebookIcon),
    GetIcon(color: green, icon: phoneIcon),
  ];
  bool? rememberMe = true;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: Provider.of<AsyncCall>(context).inAsyncCall,
            progressIndicator: SpinKitFadingCircle(
              color: green,
              size: 50,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.sp,),
                  SvgPicture.asset(
                    logoPath,
                    width: w>600 ? w *0.25 : w* 0.4,
                    height: w>600 ? w *0.25 : w* 0.4,
                    fit: BoxFit.cover,
                    color: green,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      LocaleKeys.logInScreenTitle.tr(),
                      textAlign: TextAlign.center,
                      style: UserTheme.get(
                        context: context,
                        fontSize: w>600 ? 13.sp : 16.sp,
                        fontWight: FontWeight.w600,
                        colorBright: black,
                        colorDark: white
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        getAlignText(LocaleKeys.email.tr() , context),
                        CustomerTextField(
                          hint: LocaleKeys.enterEmail.tr(),
                          reedOnly: false,
                          scure: false,
                          suffixIcon: false,
                          peffixIconData: Icons.email,
                          isPhone: false,
                          onSaved: (v){
                            if(formKey.currentState?.validate() == true){
                              email = v.toString();
                            }
                          },
                          validator: (v){
                            if(v.toString().isNotEmpty){
                              setState(() {
                                inAsyncCall = true ;
                              });
                              if(v.toString().endsWith("@gmail.com")){
                              }
                              else {
                                return "Invalid Email";
                              }
                            }
                            else {
                              return "Required *" ;
                            }
                          },
                        ),
                        getAlignText(LocaleKeys.password.tr() , context),
                        CustomerTextField(
                          hint: LocaleKeys.enterPass.tr(),
                          reedOnly: false,
                          isPhone: false,
                          scure: true,
                          suffixIcon: true,
                          peffixIconData: Icons.lock,
                          suffixIconData: Icons.remove_red_eye_rounded,
                          onSaved: (v){
                            if(formKey.currentState?.validate() == true){
                              password = v.toString();
                            }
                          },
                          validator: (v){
                            if(v.toString().isNotEmpty){
                              if(v.toString().length > 8){
                              }
                              else {
                                return "Invalid Password";
                              }
                            }
                            else {
                              return "Required *" ;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            value: rememberMe,
                            onChanged: (v) {
                              setState(() {
                                rememberMe = v;
                              });
                            },
                            checkColor: Colors.white,
                            splashRadius: 30.sp,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            side: BorderSide(width: 1.sp, color: grey),
                            activeColor: green,
                          ),
                        ),
                        Text(
                          LocaleKeys.rememberMe.tr(),
                          style: UserTheme.get(
                            fontWight: FontWeight.w500,
                            fontSize: w>600 ? 13.sp: 10.sp,
                            context: context,
                            colorBright: Colors.grey.shade900,
                            colorDark: Colors.grey.shade300
                          ),
                        ),
                        Spacer(),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, forgetPassPath);
                            },
                            child: Text(
                              LocaleKeys.forget_pass.tr(),
                              style: UserTheme.get(
                                  fontWight: FontWeight.w500,
                                  fontSize: w>600 ? 13.sp: 10.sp,
                                  context: context,
                                  colorBright: Colors.grey.shade900,
                                  colorDark: Colors.grey.shade300
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                  UserButton(
                    title: LocaleKeys.logIn.tr(),
                    method: () async{
                      if(formKey.currentState?.validate() == true){
                        Provider.of<AsyncCall>(context,listen: false).changeAsyncCall(true);
                        try{
                          formKey.currentState?.save();
                          customerData =  await UserDetails(email:  email , pass:  password);
                          await AuthCubit.get(context).logInWithEmail();
                          Navigator.pushNamed(context, homePath);
                        }catch(e){
                          print(e);
                        }
                      }
                      Provider.of<AsyncCall>(context,listen: false).changeAsyncCall(false);
                    },
                    color: green,
                  ),
                  Container(

                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 15.sp , vertical: 20.sp),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: grey,
                              height: 36,
                              thickness: 1.sp,
                            )),
                      ),
                      Text(
                        LocaleKeys.or.tr(),
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: grey
                        ),
                      ),
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: grey,
                              height: 36,
                              thickness: 1.sp,
                            )),
                      ),
                    ]),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    width: MediaQuery.of(context).size.width,
                    height: 60.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 3; i++) getIconsContainer(list[i] , ()async{
                          Provider.of<AsyncCall>(context,listen: false).changeAsyncCall(true);
                          try{
                            if(i == 0) {
                              await AuthCubit.get(context).signInWithGoogle();
                              Navigator.pushNamed(context, homePath);
                            } else if(i == 1) {
                            } else if(i == 2) {
                            } else if(i == 3) {
                              Navigator.pushNamed(context, phoneNumberPath);
                            }
                          }catch(e){
                          }
                          Provider.of<AsyncCall>(context,listen: false).changeAsyncCall(false);
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.sp),
                ],
              ),
            ),
          )
      ),
    );
  }

  getIconsContainer(GetIcon item , method) {
    return InkWell(
      onTap: method,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        width: 40.sp,
        height: 40.sp,
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return SvgPicture.asset(
            item.icon,
          );
        }),
      ),
    );
  }
}

class GetIcon {
  var color, icon;
  GetIcon({required this.icon, required this.color});
}
