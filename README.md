[![pub package](https://img.shields.io/pub/v/flutter_dropdown_alert.svg)](https://pub.dartlang.org/packages/flutter_dropdown_alert)

# flutter_dropdown_alert

A dropdown alert package for flutter

Dropdown alert will help to notify to user when you call api success, error or something like that. It's will similar with push notification but you can custom more than that. You can show alert at anywhere without widget.

## Demo

### Top:
![](https://github.com/vantuan88291/flutter_dropdown_alert/raw/master/screenshot/dropdown.gif)

### Bottom:
![](https://github.com/vantuan88291/flutter_dropdown_alert/raw/master/screenshot/demo-2.png)

##  How to use it.

```yaml
# pubspec.yaml

dependencies:
  flutter:
    sdk: flutter
  flutter_dropdown_alert: <last-version>
```

Just create a `Stack` widget and add `DropdownAlert()` inside `MaterialApp` which should be in main.dart like this:
```dart
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
```

```dart
 MaterialApp(
       title: 'Dropdown Alert Demo',
       theme: ThemeData(
         visualDensity: VisualDensity.adaptivePlatformDensity,
       ),
       home: Stack(
         children: [
           MyHomePage(title: 'Flutter Dropdown Alert Demo'),
           DropdownAlert()
         ],
       ),
     );
```

## Show alert anywhere, even inside bloc without widget:

Next, import 'alert_controller.dart' into your dart code

```dart
import 'package:flutter_dropdown_alert/alert_controller.dart';
```

```dart
   AlertController.show("Title", "message here!", TypeAlert.success, payload);
```

The `payload` param is `Map<String, dynamic>`, this param is optional, should use to give data into the alert and get it when click on alert.

## Hide alert:
The alert will automatically hide, but if you use `delayDismiss: 0`, it will freeze and not auto hide, you have to hide the alert by this code:
```dart
   AlertController.hide();
```

## Listener when click on alert:

There are 2 ways to do that:

- Using listener of controller, put this code inside `initState()` of widget:
```dart
   AlertController.onTabListener((Map<String, dynamic>? payload, TypeAlert type) {
         print("$payload - $type");
       });
```
- Using param `onTap`:
```dart
   DropdownAlert(onTap: (Map<String, dynamic> payload?, TypeAlert type) {
                print("$payload - $type");
             },)
```



## TypeAlert
| Type                       | description                                                                           |
| -------------------------- | ------------------------------------------------------------------------------------- |
| TypeAlert.success          | Type when action success, the background of alert will green                          |
| TypeAlert.warning          | Type when action warning, the background of alert will brown                          |
| TypeAlert.error            | Type when action error, the background of alert will red                              |


## parameters
| parameter                  | description                                                                           | default                                                                                                                                                                               |
| -------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| onTap                      | Callback when tab to alert, will give: Function(Map<String, dynamic>, TypeAlert)      | null                                                                                                                                                                                  |
| successImage               | Image.asset() of success alert, uri of assets image                                   | Icon widget                                                                                                                                                                           |
| warningImage               | Image.asset() of warning alert, uri of assets image                                   | Icon widget                                                                                                                                                                           |
| errorImage                 | Image.asset() of error alert, uri of assets image                                     | Icon widget                                                                                                                                                                           |
| errorBackground            | Color of background when error                                                        | Colors.red                                                                                                                                                                            |
| successBackground          |                                                                                       | Colors.green                                                                                                                                                                          |
| warningBackground          |                                                                                       | 0xFFCE863D                                                                                                                                                                            |
| titleStyle                 | TextStyle of title                                                                    |                                                                                                                                                                                       |
| contentStyle               | TextStyle of content                                                                  |                                                                                                                                                                                       |
| maxLinesTitle              |                                                                                       | null                                                                                                                                                                                  |
| maxLinesContent            |                                                                                       | null                                                                                                                                                                                  |
| duration                   | duration of animation                                                                 | 300                                                                                                                                                                                   |
| delayDismiss               | delay time when alert auto dismiss, set to 0 if you want to freeze alert              | 3000                                                                                                                                                                                  |
| position                   | show the position of alert, include: AlertPosition.TOP, AlertPosition.BOTTOM          | AlertPosition.TOP                                                                                                                                                                     |


`The ideal from react-native-dropdownalert`