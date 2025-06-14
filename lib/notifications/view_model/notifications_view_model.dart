

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smart_tracking/api/api_exception.dart';
import 'package:smart_tracking/api/api_result.dart';
import 'package:smart_tracking/services/home_services.dart';
import 'package:smart_tracking/utils/app_base_view_model.dart';
import 'package:smart_tracking/utils/app_component.dart';
import 'package:smart_tracking/notifications/repository/notifications_repository.dart';
import 'package:smart_tracking/utils/handle_api_error_dialog.dart';
import 'package:smart_tracking/api/model/config_notification.dart';

class NotificationsViewModel extends AppBaseViewModel {
  final _homeServices = locator<HomeServices>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final formKey = GlobalKey<FormBuilderState>();
  late List<ConfigNotification> notifications = [];
  bool loading = false;
  int indexLoading = -1;
  final _notificationRepository = locator<NotificationsRepository>();

  get user => _homeServices.user.value;

  NotificationsViewModel() {
    getNotifications();
  }

  Future<void> getNotifications() async {
    loading = true;
    notifyListeners();
    _notificationRepository.getNotifications().then((response) async {
      if (response.status == Status.COMPLETED) {
        notifications = response.data as List<ConfigNotification>;
      } else {
        throw response.apiException as ApiException;
      }
    }).catchError((error) {
      loading = false;
      notifyListeners();
      handleApiErrorDialog(error);
    }).whenComplete((){
      loading = false;
      notifyListeners();
    });
  }

  Future<void> updateNotification(ConfigNotification notification, int index) async {
    indexLoading = index;
    notifyListeners();
    _notificationRepository.toggle_enabled(notification).then((response) async {
      if (response.status == Status.COMPLETED) {
        notifications[index] = response.data as ConfigNotification;
      } else {
        throw response.apiException as ApiException;
      }
    }).catchError((error) {
      indexLoading = -1;
      notifyListeners();
      handleApiErrorDialog(error);
    }).whenComplete((){
      indexLoading = -1;
      notifyListeners();
    });
  }


}