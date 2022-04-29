import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/CustomerTheme.dart';
import '../../Constants/colors.dart';
import '../../Constants/image_path.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/DarkTheme.dart';
import '../../Language/locale_keys.g.dart';
import '../Widgets/customer_button.dart';

class SendLoginLink extends StatefulWidget {

  static String id = "SendLoginLink";
  const SendLoginLink({Key? key}) : super(key: key);

  @override
  _SendLoginLinkState createState() => _SendLoginLinkState();
}

class _SendLoginLinkState extends State<SendLoginLink> {
  Map<String , int> map = {"sendEmail" : 0 , "sendSMS" : 1};
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
                  CircleAvatar(
                    radius: 29.sp,
                    backgroundImage: AssetImage(profilePic),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 15.sp,
                        bottom: 10.sp
                    ),
                    child: Text(
                      "Haidy Mohmed",
                      style:  UserTheme.get(
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
                      LocaleKeys.sendEmilHint.tr(),
                      textAlign: TextAlign.center,
                      style: UserTheme.get(
                          fontSize: 14.sp,
                          fontWight: FontWeight.w500,
                          context: context,
                          colorBright: black,
                          colorDark: white
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 22.sp,
                      horizontal: 20.sp
                    ),
                    padding: EdgeInsets.only(
                      top: 10.sp,
                      bottom: 10.sp,
                      left: 10.sp
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: grey),
                      color: Provider.of<UserDarkTheme>(context).isDark?  Colors.grey.shade700 : white,
                      borderRadius: BorderRadius.circular(10.sp)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RadioListTile(
                          title: Text(
                            LocaleKeys.sendAnEmail.tr(),
                            style: UserTheme.get(
                                context: context,
                                fontSize: 15.sp,
                                fontWight: FontWeight.w700,
                                colorBright: black,
                                colorDark: white
                            )
                          ),
                          subtitle: Text(
                            "ha********01@gmail.com",
                            style: UserTheme.get(
                              context: context,
                              fontSize: 13.sp,
                              fontWight: FontWeight.w600,
                              colorBright: grey,
                              colorDark: Colors.grey.shade400
                          )
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: null,
                          groupValue: null,
                          activeColor: green,
                          onChanged: (Null? value) {
                          },
                        ),
                        RadioListTile(
                          title: Text(
                            LocaleKeys.sendSmsMessage.tr(),
                            style: UserTheme.get(
                                context: context,
                                fontSize: 15.sp,
                                fontWight: FontWeight.w700,
                                colorBright: black,
                                colorDark: white
                            )
                          ),
                          subtitle: Text(
                            "********325",
                            style: UserTheme.get(
                                context: context,
                                fontSize: 13.sp,
                                fontWight: FontWeight.w600,
                                colorBright: grey,
                                colorDark: Colors.grey.shade400
                            )
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: null,
                          groupValue: null,
                          activeColor: green,
                          onChanged: (Null? value) {
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.sp,
                    ),
                    child: UserButton(
                        title: LocaleKeys.sendLoginLinkButton.tr(),
                        color: green,
                        method: (){
                        }
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    width: MediaQuery.of(context).size.width * 0.5,
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
