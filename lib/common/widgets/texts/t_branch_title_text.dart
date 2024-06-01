import 'package:flutter/material.dart';
import '../../../utils/constants/enums.dart';
class TBranchTitleText extends StatelessWidget {
  const TBranchTitleText({super.key,
    this.color,
    required this.title,
     this.maxLines =1,
     this.textAlign =TextAlign.center,
    this.branchTextSize = TTextSize.small,
  });
final Color? color;

final String title;
final int maxLines;
final TextAlign textAlign;
final TTextSize branchTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(title,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
      style: branchTextSize== TTextSize.small ?Theme.of(context).textTheme.labelMedium!.apply(color: color):
      branchTextSize== TTextSize.medium ? Theme.of(context).textTheme.bodyLarge!.apply(color: color):
      branchTextSize== TTextSize.largre ? Theme.of(context).textTheme.titleLarge!.apply(color: color):
      Theme.of(context).textTheme.bodyMedium!.apply(color: color)
    );
  }

}

