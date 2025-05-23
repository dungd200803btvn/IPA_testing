import 'package:flutter/material.dart';
import 'package:app_my_app/l10n/app_localizations.dart';
class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    this.title = "",
    this.titleWidget, // Thêm titleWidget để hiển thị dữ liệu động
    this.buttonTitle = "View all" ,
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title;
  final Widget? titleWidget; // Widget có thể thay thế title
  final String buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Nếu có titleWidget thì dùng, nếu không thì dùng title mặc định
        Expanded(
          child: titleWidget ??
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        ),
        if (showActionButton) TextButton(onPressed: onPressed, child: Text(lang.translate('view_all'))),
      ],
    );
  }
}
