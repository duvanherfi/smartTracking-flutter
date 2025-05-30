import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/style/dialog.style.dart';

Future<void> showPiDialog(
  String? description, {
  String? title,
  dynamic data,
  void Function()? onCancelEvent,
  void Function(dynamic data)? onAcceptEvent,
  bool showCancelButton = false,
  String? mainButtonTitle,
  String? cancelButtonTitle,
  bool barrierDismissible = false,
}) async {
  final response = await galleryDialogService.showCustomDialog<dynamic, dynamic>(
    variant: DialogType.confirmDialog,
    title: title,
    data: data,
    description: description ?? '',
    mainButtonTitle: mainButtonTitle ?? "Aceptar",
    secondaryButtonTitle: cancelButtonTitle ?? "Cancelar",
    showIconInSecondaryButton: showCancelButton,
    barrierDismissible: barrierDismissible,
  );
  if (!(response?.confirmed ?? false)) {
    onCancelEvent?.call();
  } else {
    onAcceptEvent?.call(response?.data);
  }
}
