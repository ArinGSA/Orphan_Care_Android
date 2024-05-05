import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedbackWidget extends StatefulWidget {
  final bool? isSelected;
  final double? initialRating;

  const FeedbackWidget({super.key, this.isSelected, this.initialRating});

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        Container(
          height: 0.045.sh,
          width: 0.8.sw,
          decoration: BoxDecoration(
              color: widget.isSelected! ? appBarTopColor : backgroundColor,
              border: Border.all(
                  color: widget.isSelected! ? buttonColor : Colors.black),
              borderRadius: BorderRadius.circular(8.0).r),
          child: RatingBar.builder(
            initialRating: widget.initialRating!,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            ignoreGestures: true,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) =>  Icon(
              Icons.star,
              color: Colors.amber,
              size: 1.sp,
            ),
            onRatingUpdate: (double value) {},
          ),
        ),
        widget.isSelected!
            ? Padding(
                padding: const EdgeInsets.only(top: 7, right: 10.0).r,
                child: Icon(FontAwesomeIcons.solidCircleCheck,
                    size: 15.r, color: Theme.of(context).colorScheme.primary),
              )
            : const SizedBox(),
      ],
    );
  }
}
