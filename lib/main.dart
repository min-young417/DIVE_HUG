import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dive_hug/route/routes.dart';
import 'package:dive_hug/common/custom_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .env 파일 로드
  await dotenv.load(fileName: ".env");

  // 네이버 지도 초기화
  await FlutterNaverMap().init(
    clientId: dotenv.env['NAVER_MAP_CLIENT_ID']!,
    onAuthFailed: (ex) {
      debugPrint("네이버 지도 인증 실패: $ex");
    },
  );

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
              initialRoute: '/',
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