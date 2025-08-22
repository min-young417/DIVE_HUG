import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dive_hug/route/routes.dart';
import 'package:dive_hug/common/custom_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .env 파일 로드
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ScreenUtilInit(
          designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
          builder: (context, child) {
            return GetMaterialApp(
              title: 'HUG App Extension',
              theme: CustomTheme.themeData,
              initialRoute: '/predictMap',
              getPages: GetXRouter.routes,
              defaultTransition: Transition.cupertino,
              debugShowCheckedModeBanner: false,
            );
          }
        );
      }
    );
  }
}