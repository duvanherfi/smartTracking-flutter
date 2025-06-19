import 'package:flutter/material.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/build_context.extension.dart';
import 'package:smart_tracking/utils/components/html_text.component.dart';
import 'package:smart_tracking/utils/extensions/strings.extensions.dart';
import 'package:smart_tracking/utils/extensions/texts.extension.dart';
import 'package:smart_tracking/utils/extensions/widget.extension.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfirmDialog extends StatefulWidget {
  final DialogRequest<dynamic>? request;
  final void Function(DialogResponse<dynamic>) completer;

  const ConfirmDialog({
    required this.request,
    required this.completer,
    super.key,
  });

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  Size htmlSize = Size(250, 100);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.request?.description?.isHTML ?? false) {
      setState(() {
        htmlSize = calculateSizeHtmlText(
          widget.request?.description ?? '',
          context.bodyMedium ?? const TextStyle(
            fontSize: 20
          ),
        );
      });
    }
  }

  Size calculateSizeHtmlText(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 300);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        scrollable: true,
        actionsPadding: const EdgeInsets.all(5),
        actions: [
          if (widget.request?.showIconInSecondaryButton ?? false) ...[
            TextButton(
              onPressed: () =>
                  galleryDialogService.completeDialog(DialogResponse()),
              child: Text(
                widget.request?.secondaryButtonTitle ?? "Cancelar",
                style: context.bodyLarge?.setColor(Color(0xFF6c18db)),
              ),
            ),
          ],
          TextButton(
            onPressed: () => galleryDialogService.completeDialog(
              DialogResponse(confirmed: true),
            ),
            child: Text(
              widget.request?.mainButtonTitle ?? "Aceptar",
              style: context.bodyLarge?.setColor(Color(0xFF6c18db)),
            ),
          ),
          const SizedBox(width: 1),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            if (widget.request?.title?.isNotEmpty ?? false) ...[
              Text(
                widget.request?.title ?? '',
                style: context.titleSmall?.bold,
                maxLines: 6,
              ),
              const SizedBox(height: 10),
            ],
            if (widget.request?.data is Widget) ...[
              FittedBox(
                child: widget.request?.data as Widget,
              ).withPadding(const EdgeInsets.symmetric(vertical: 10)),
            ] else if (widget.request?.description?.isHTML ?? false) ...[
              PiHtmlText(
                content: widget.request?.description ?? '',
                maxLines: 20,
              ).box(
                width: htmlSize.width,
                height: htmlSize.height + 10,
              ),
            ] else ...[
              Text(
                widget.request?.description ?? '',
                style: context.bodyMedium,
                maxLines: 20,
              ),
            ],
          ],
        ),
      );
}
