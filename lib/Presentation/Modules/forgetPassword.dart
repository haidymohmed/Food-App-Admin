import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:sizer/sizer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/route_id.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/DarkTheme.dart';
import '../../Language/locale_keys.g.dart';
import '../Widgets/customer_button.dart';
import '../Widgets/customer_textField.dart';

class ForgetPassword extends StatefulWidget {
  static String id = "ForgetPassword";
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall : Provider.of<AsyncCall>(context).inAsyncCall,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height ,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.sp,),
                  Container(
                    width: 60.sp,
                    height: 60.sp,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(42.sp),
                      border: Border.all(color: Provider.of<UserDarkTheme>(context).isDark?  white :Colors.black , width: 2)
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: 30.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15.sp,
                      bottom: 10.sp
                    ),
                    child: Text(
                      LocaleKeys.troubleLoggingIn.tr(),
                      style: UserTheme.get(
                        fontSize: 15.sp,
                        fontWight: FontWeight.w700,
                        context: context,
                        colorBright: black,
                        colorDark: white
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.sp
                    ),
                    child: Text(
                      LocaleKeys.forgetPassHint.tr(),
                      textAlign: TextAlign.center,
                      style: UserTheme.get(
                          fontSize: 13.sp,
                          fontWight: FontWeight.w500,
                          context: context,
                          colorBright: black,
                          colorDark: white
                      ),
                    ),
                  ),
                  Container(
                    margin : EdgeInsets.symmetric(
                        horizontal: 20.sp,
                      vertical: 10.sp
                    ),
                    child: DefaultTabController(
                        length: 2, // length of tabs
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: TabBar(
                                labelColor: Provider.of<UserDarkTheme>(context).isDark?  white :Colors.black,
                                unselectedLabelColor: Colors.grey.shade600,
                                indicatorColor: Provider.of<UserDarkTheme>(context).isDark?  white :Colors.black,
                                indicatorWeight: 3,
                                tabs: [
                                  Text(
                                    LocaleKeys.userName.tr(),
                                    style: UserTheme.get(
                                        fontSize: 16.sp,
                                        fontWight: FontWeight.w700,
                                        context: context,
                                        colorBright: null,
                                        colorDark: null
                                    ),
                                  ),
                                  Text(
                                    LocaleKeys.phone.tr(),
                                    style: UserTheme.get(
                                        fontSize: 16.sp,
                                        fontWight: FontWeight.w700,
                                        context: context,
                                        colorBright: null,
                                        colorDark: null
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 90.sp,
                                padding: EdgeInsets.only(top: 10.sp),
                                child: TabBarView(
                                    children: <Widget>[
                                    Container(
                                      child: Center(
                                        child: CustomerTextField(
                                          hint: LocaleKeys.enterYourName.tr(),
                                          reedOnly: false,
                                          isPhone: false,
                                          scure: false,
                                          suffixIcon: true,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        child: Center(
                                          child: CustomerTextField(
                                            hint: LocaleKeys.enterYourPhone.tr(),
                                            reedOnly: false,
                                            isPhone: true,
                                            scure: false,
                                            suffixIcon: true,
                                          ),
                                        ),
                                      ),
                                ]
                                )
                            )
                          ]
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.sp,
                    ),
                    child: UserButton(
                        title: LocaleKeys.next.tr(),
                        color: green,
                        method: (){
                          Navigator.pushNamed(context, sendEmailLinkPath);
                        }
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    width: MediaQuery.of(context).size.width,
                    height: 50.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                          },
                          child: Text(
                            LocaleKeys.needMoreHelp.tr(),
                            style: UserTheme.get(
                                context: context,
                                fontSize: 14.sp,
                                fontWight: FontWeight.w700,
                                colorBright: green,
                                colorDark: green
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
