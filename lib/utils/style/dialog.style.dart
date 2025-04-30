import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/utils/components/confirm_dialog.component.dart';
enum DialogType {
  confirmDialog,
}
void setupDialogUi() {
  final Map<
      dynamic,
      Widget Function(
        BuildContext,
        DialogRequest<dynamic>,
        void Function(DialogResponse<dynamic>),
      )> builders = {
    DialogType.confirmDialog: (context, request, completer) => ConfirmDialog(
          key: const Key('confirmDialog'),
          request: request,
          completer: completer,
        ),
  };
  galleryDialogService.registerCustomDialogBuilders(builders);
}
