import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin/Domain/UpladImage/image_cubit.dart';
import 'package:restaurant_admin/Domain/UpladImage/image_status.dart';
import 'package:restaurant_admin/Presentation/Modules/log_in.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'Domain/AsyncCall.dart';
import 'Domain/Auth/auth_cubit.dart';
import 'Domain/Auth/auth_state.dart';
import 'Domain/BlockObserver.dart';
import 'Domain/ChangeLanguage/language_cubit.dart';
import 'Domain/ChangeLanguage/language_state.dart';
import 'Domain/CheckConnection/connect_cubit.dart';
import 'Domain/CheckConnection/connect_state.dart';
import 'Domain/DarkTheme.dart';
import 'Language/codegen_loader.g.dart';
import 'Presentation/Dialogs/no_internet_connection.dart';
import 'Presentation/Modules/splach_screen.dart';
import 'app_route.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  BlocOverrides.runZoned(() {
     runApp(
        DevicePreview(
           enabled: true,//!kReleaseMode
           builder: (context)=> MultiProvider(
                    providers: [
                      BlocProvider (create: (_) => CheckConnectionCubit()..initialConnection()),
                      BlocProvider (create: (_) => ChangeLanguageCubit()),
                      BlocProvider (create: (_) => AuthCubit()),
                      BlocProvider( create: (_) => ImageCubit()),
                      ChangeNotifierProvider(create: (_) => AsyncCall()),
                      ChangeNotifierProvider(create: (_) => UserDarkTheme()),
                    ],
                    child: EasyLocalization(
                        supportedLocales: const [Locale('en'), Locale('ar')],
                        saveLocale: true,
                        path: 'asset/Language', // <-- change the path of the translation files
                        fallbackLocale: const Locale('en'),
                        assetLoader: const CodegenLoader(),
                        child: const FoodApp()
                    )
                )
        )
     );
    },
    blocObserver: MyBlocObserver(),
  );
}

class FoodApp extends StatefulWidget {
  const FoodApp({Key? key}) : super(key: key);
  @override
  _FoodAppState createState() => _FoodAppState();
}
class _FoodAppState extends State<FoodApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return BlocBuilder<ImageCubit , ImageStatus>(
            builder: (context , status){
              return BlocConsumer<AuthCubit , AuthStates>(
                listener: ( context , state) {},
                builder: (context , state){
                  return  BlocBuilder<CheckConnectionCubit , CheckConnectionState>(
                    builder: (BuildContext context, state) {
                      if( state is Connected ) {
                        //print("connected");
                        //OneContext().popDialog();
                      }
                      else if(state is DisConnected){
                        print("Dis connected");
                        OneContext().showDialog(
                          barrierDismissible: false,
                          builder: (_) => ShowCustomerDialog(title : "No Internet Connection.",
                              subtitle: "Please check your internet connection and try again ." ,dismiss: false) ,
                        );
                      }
                      return  BlocBuilder<ChangeLanguageCubit , ChangeLanguageState>(
                          builder: (context, state) {
                            return MaterialApp(
                              theme: ThemeData(
                                  brightness: Provider.of<UserDarkTheme>(context).isDark ? Brightness.dark : Brightness.light
                              ),
                              supportedLocales: context.supportedLocales,
                              localizationsDelegates: context.localizationDelegates,
                              locale: context.locale,
                              useInheritedMediaQuery: true,
                              debugShowCheckedModeBanner: false,
                              onGenerateRoute : AppRoute.onGenerateRoute,
                              home: SplashScreen(nextScreen: const LogIn()),
                              builder: OneContext().builder,
                            );
                          }
                      );
                    },
                  );
                },
              );
            },
        );
      }
    );
  }
}