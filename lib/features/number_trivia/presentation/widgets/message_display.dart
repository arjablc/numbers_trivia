import '../../../../core/extensiosn/context_extension.dart';
import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final Widget child;
  final bool isError;
  const MessageDisplay({
    super.key,
    required this.isError,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isError
              ? context.theme.colorScheme.error
              : context.theme.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(20)),
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Center(child: child),
    );
  }
}
