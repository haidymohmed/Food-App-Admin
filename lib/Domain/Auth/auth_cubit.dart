import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Constants/userInfo.dart';
import '../../Presentation/Dialogs/AppToast.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates>{
  late String id;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static AuthCubit get(context) => BlocProvider.of(context);
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  // ignore: non_constant_identifier_names
  AuthCubit() : super(InitAuthState());
  signInWithPhone(phoneNumber)async{
    emit(PhoneLoading());
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (credential){
        auth.signInWithCredential(credential).then((value) {
          emit(OTPSuccess());
        });
      },
      verificationFailed: (error){
      emit(OTPFailed(error: error.message));
      },
      codeSent: (String phoneId , [int? token]){
        id = phoneId;
        emit(PhoneSuccess(phoneNumber: phoneNumber));
      },
      codeAutoRetrievalTimeout: (String c){
        emit(OTPFailed(error: "Timeout"));
      }
    );
  }
  logInWithEmail()async{
    // ignore: argument_type_not_assignable_to_error_handler
    await auth.signInWithEmailAndPassword(email: customerData.email, password: customerData.pass!).catchError((e){
      showToastError(msg: e.toString(), state: ToastedStates.ERROR);
    }).then((value){
      customerData.id = value.user?.uid;
      getUserData(customerData.id);
    });
  }
  submitOTP(otpCode){
    emit(OTPLoading());
    AuthCredential credential = PhoneAuthProvider.credential(verificationId: id , smsCode: otpCode.toString());
    auth.signInWithCredential(credential).then((value) => {
      if(value.user != null){

      }
    // ignore: argument_type_not_assignable_to_error_handler
    }).catchError((FirebaseAuthException e){
      showToastError(
          state: ToastedStates.ERROR,
          msg: e.message.toString()
      );
      emit(OTPFailed(error: e.message.toString()));
    });
  }
  forgotPassword(email)async{
    // ignore: argument_type_not_assignable_to_error_handler
    await auth.sendPasswordResetEmail(email: email).catchError((FirebaseAuthException e){
      showToastError(msg: e.message.toString(), state: ToastedStates.ERROR);
    });
  }
  getUserData(id){
    FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        customerData.fromJason(documentSnapshot.data());
      } else {
        print('Document does not exist on the database');
      }
    });
  }
  signInWithGoogle() async {
    print("start");
    // Sign in with Google
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    print("2");
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    print("2");
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print("4");
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    print("done");
  }
  changePassword({required oldPass ,required newPass , msg = "Password"}) async{
     var email = auth.currentUser?.email;
     AuthCredential credential = EmailAuthProvider.credential(email: email.toString(), password: oldPass);
     auth.currentUser?.reauthenticateWithCredential(credential).then((value) async{
       await auth.currentUser?.updatePassword(newPass).onError((FirebaseAuthException e, stackTrace) {
         showToastError(
             msg: e.message.toString(),
             state: ToastedStates.ERROR
         );
       });
      }).onError((FirebaseAuthException e, stackTrace) {
       showToastError(
           msg: e.message.toString(),
           state: ToastedStates.ERROR
       );
     });
  }
  changeEmail({required oldPass ,required newEmail ,required newPass})async{
    var email = auth.currentUser?.email;
    AuthCredential credential = EmailAuthProvider.credential(email: email.toString(), password: oldPass);
    auth.currentUser?.reauthenticateWithCredential(credential).then((value) async{
      await auth.currentUser?.updatePassword(newEmail).onError((FirebaseAuthException e, stackTrace) {
        showToastError(
            msg: e.message.toString(),
            state: ToastedStates.ERROR
        );
      }).then((value) {
        changePassword(oldPass:  oldPass ,newPass :newPass , msg: "Email");
      });
    }).onError((FirebaseAuthException e, stackTrace) {
      showToastError(
          msg: e.message.toString(),
          state: ToastedStates.ERROR
      );
    });
  }
  signOut(){
    auth.signOut();
  }
}
