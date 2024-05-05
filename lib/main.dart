import 'package:flutter/material.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

CommonController commonController = Get.find<CommonController>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CommonController());
  await commonController.initializeHive();

  runApp(const OrphanCareApp());
}

class OrphanCareApp extends StatelessWidget {
  const OrphanCareApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, _) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.initial,
            defaultTransition: Transition.fade,
            getPages: AppPages.pages,
          );
        });
  }
}
