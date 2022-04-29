import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../Domain/AsyncCall.dart';
import '../../Constants/colors.dart';
import '../../Domain/Auth/auth_cubit.dart';
import '../../Domain/DarkTheme.dart';
import '../Widgets/change_textfield.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/customer_button.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String newEmail , oldPass , newPass , confirmPass;
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
                    title: "Change Email"
                ),
                SizedBox(height: 30.sp,),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      getChangeTextField(
                          title: "New Email",
                        onSave: (v){
                            setState(() {
                              this.newEmail = v.toString();
                            });
                        }
                      ),
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
                              this.newPass = v.toString();
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
                          await AuthCubit.get(context).changeEmail(oldPass: oldPass, newEmail: newEmail, newPass: confirmPass);
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
