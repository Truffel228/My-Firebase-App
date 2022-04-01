import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, this.onPressed, this.child, this.color})
      : super(key: key);

  final VoidCallback? onPressed;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          // As you said you dont need elevation. I'm returning 0 in both case
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return color ?? theme.primaryColor;
            }
            return color ??
                theme.primaryColor; // Defer to the widget's default.
          },
        ),
        elevation: MaterialStateProperty.resolveWith<double>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return 0;
            }
            return 0;
          },
        ),
      ),
    );
  }
}
