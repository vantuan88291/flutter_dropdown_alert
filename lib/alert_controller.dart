import 'model/data_alert.dart';

typedef VoidCallBack = void Function();
typedef VoidCallBackListenerTab = void Function(
    Map<String, dynamic>, TypeAlert);
typedef VoidCallBackWithValue = void Function(String, String, TypeAlert,
    [Map<String, dynamic>]);

class AlertController {
  VoidCallBackWithValue _show;
  VoidCallBack _hide;
  VoidCallBackListenerTab _tabListener;

  static AlertController instance = AlertController._init();

  factory AlertController() => instance;

  AlertController._init() {
    print("AlertController was created!");
  }

  static onTabListener(VoidCallBackListenerTab tabListener) {
    instance._tabListener = tabListener;
  }

  VoidCallBackListenerTab getTabListener() {
    return _tabListener;
  }

  static show(String title, String message, TypeAlert type,
      [Map<String, dynamic> payload]) {
    instance._show(title, message, type, payload);
  }

  static hide() {
    instance._hide();
  }

  setShow(VoidCallBackWithValue show) {
    this._show = show;
  }

  setHide(VoidCallBack hide) {
    this._hide = hide;
  }

  dispose() {
    this._show = null;
    this._hide = null;
    this._tabListener = null;
  }
}
