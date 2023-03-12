import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import '../constants/colors.dart';
import '../controllers/loading_controller.dart';


class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    LoadingController controller = Get.put(LoadingController());

    return Scaffold(
      // backgroundColor: Colors.white10,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            // LoadingAnimationWidget.flickr(
            //   size: 90,
            //   leftDotColor: AppColors.customGreen,
            //   rightDotColor: AppColors.customAmber,
            // ),

            LoadingAnimationWidget.discreteCircle(
              color: AppColors.customAmber,
              size: 70,
              secondRingColor: AppColors.customGreen,
              thirdRingColor: Colors.grey,
            ),

            30.height,

            Text(
              controller.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),

          ],
        ),
      ).center(),

    );
  }
}





