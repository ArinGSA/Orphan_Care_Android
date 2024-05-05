import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/app_styles.dart';
import 'package:orphan_care/app/ui/widgets/custom_app_bar.dart';
import 'package:orphan_care/app/ui/widgets/custom_login_button_widget.dart';
import 'package:orphan_care/app/ui/widgets/feedback_widget.dart';
import 'package:orphan_care/app/ui/widgets/message_widget.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  int selectedIndex = -1;
  final _feedBackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: "Rating",
        actionWidget: SizedBox(),
      ),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Enter your Ratings......",
                style: appBarTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.all(10.r),
                  height: 0.5.sh,
                  width: 0.8.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: textColor)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 0.29.sh,
                          width: 0.8.sw,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: FeedbackWidget(
                                    initialRating: index + 1,
                                    isSelected: selectedIndex == index,
                                  ));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: 10);
                            },
                          ),
                        ),
                        Container(
                          width: 0.8.sw,
                          decoration: BoxDecoration(
                              border: Border.all(color: textColor),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: TextFormField(
                            maxLines: 5,
                            controller: _feedBackController,
                            decoration: InputDecoration(
                                hintText: "Enter your Ratings......",
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(8.r)),
                          ),
                        )
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              CustomLoginButtonWidget(
                  elevatedButtonStyle: loginButtonStyle,
                  height: 0.005.sh,
                  width: 0.2.sw,
                  buttonFunction: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const MessageWidget(
                          isAdoptSubmitted: false,
                          isFeedback: true,
                          isPayment: false,
                          isAdoptRequestDeclined: false,
                          isAdoptRequestAccepted: false,
                          isPaymentSuccess: false,
                        ),
                      ),
                    );
                  },
                  buttonText: "Submit"),
            ],
          ),
        ),
      ),
    );
  }
}
