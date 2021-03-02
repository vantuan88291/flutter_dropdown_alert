import 'model/data_alert.dart';

typedef VoidCallBack = void Function();
typedef VoidCallBackListenerTab = void Function(
    Map<String, dynamic>, TypeAlert);
typedef VoidCallBackWithValue = void Function(String, String, TypeAlert,
    [Map<String, dynamic>]);

class AlertController {
  VoidCallBackWithValue show;
  VoidCallBack hide;
  VoidCallBackListenerTab tabListener;

  static AlertController instance = AlertController._init();

  factory AlertController() => instance;

  AlertController._init() {}

  onTabListener(VoidCallBackListenerTab tabListener) {
    this.tabListener = tabListener;
  }

  dispose() {
    this.show = null;
    this.hide = null;
    this.tabListener = null;
  }
}
