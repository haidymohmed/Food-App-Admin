import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../Constants/colors.dart';
import '../../Domain/AsyncCall.dart';
import '../../Domain/Auth/auth_cubit.dart';
import '../../Domain/DarkTheme.dart';
import '../Widgets/change_textfield.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/customer_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String  oldPass , newPass , confirmPass;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: Provider.of<AsyncCall>(context).inAsyncCall,
          child: Scaffold(
            backgroundColor: Provider.of<UserDarkTheme>(context).isDark? null  : background,
            body: Column(
              children: [
                getAppBar(
                    context: context,
                    perffix: const BackButton(),
                    suffix: Container(width: 25.sp,),
                    title: "Change Password"
                ),
                SizedBox(height: 20.sp,),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      getChangeTextField(
                          title: "Current Password",
                          onSave: (v){
                            setState(() {
                              this.oldPass = v.toString();
                            });
                          }
                      ),
                      getChangeTextField(
                          title: "New Password ",
                          contraller: controller,
                          onSave: (v){
                            setState(() {
                              this.newPass = v.toString();
                            });
                          }
                      ),
                      getChangeTextField(
                          title: "Confirm New Password ",
                          onValidate: (v){
                            if(v.toString() == controller.text){}
                            else {
                              return "Password doesnot match !";
                            }
                          },
                          onSave: (v){
                            setState(() {
                              this.confirmPass = v.toString();
                            });
                          }
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.sp,),
                UserButton(
                    title: "Submit",
                    color: green,
                    method: ()async {
                      Provider.of<AsyncCall>(context , listen: false).changeAsyncCall(true);
                      if(formKey.currentState?.validate() == true){
                        formKey.currentState?.save();
                        try{
                          await AuthCubit.get(context).changePassword(oldPass: oldPass,newPass: confirmPass);
                        }catch(e){
                          print(e.toString());
                        }
                      }
                      Provider.of<AsyncCall>(context , listen: false).changeAsyncCall(false);
                    }
                ),
              ],
            ),
          ),
        )
    );
  }
}
