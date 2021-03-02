import 'dart:async';
import 'package:flutter/material.dart';

import 'alert_controller.dart';
import 'model/data_alert.dart';

typedef VoidCallBack = void Function(Map<String, dynamic>, TypeAlert);

class DropdownAlert extends StatefulWidget {
  final VoidCallBack onTap;
  final String successImage;
  final String warningImage;
  final String errorImage;
  final Color errorBackground;
  final Color successBackground;
  final Color warningBackground;
  final TextStyle titleStyle;
  final TextStyle contentStyle;
  final int maxLinesTitle;
  final int maxLinesContent;
  final int duration;
  final int delayDismiss;

  const DropdownAlert(
      {Key key,
      this.onTap,
      this.successImage,
      this.warningImage,
      this.errorImage,
      this.errorBackground,
      this.successBackground,
      this.warningBackground,
      this.titleStyle,
      this.contentStyle,
      this.maxLinesTitle,
      this.maxLinesContent,
      this.duration,
      this.delayDismiss})
      : super(key: key);

  @override
  DropdownAlertWidget createState() => DropdownAlertWidget();
}

class DropdownAlertWidget extends State<DropdownAlert>
    with TickerProviderStateMixin {
  final DURATION = 300;
  final DELAY = 3000;
  AnimationController _animationController;
  Animation _animationPush;
  Timer _timer;
  Timer _timerRelay;
  AlertController _controller;
  String title;
  String message;
  TypeAlert type;
  Map<String, dynamic> payload;

  int getDuration() {
    if (widget.duration != null && widget.duration > 0) {
      return widget.duration;
    }
    return DURATION;
  }

  int getDelay() {
    if (widget.delayDismiss != null && widget.delayDismiss > 0) {
      return widget.delayDismiss;
    } else if (widget.delayDismiss == null) {
      return DELAY;
    } else if (widget.delayDismiss <= 0) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AlertController();
    _controller.setShow(show);
    _controller.setHide(hide);
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: getDuration()));
    _animationPush =
        Tween(begin: -180.0, end: 0.0).animate(_animationController);
  }

  show(String title, String message, TypeAlert type,
      [Map<String, dynamic> payload]) {
    final delay = getDelay();
    if (!_animationController.isDismissed) {
      cancelTimerRelay();
      cancelTimer();
      _animationController.reverse();
      _timerRelay = Timer(Duration(milliseconds: getDuration()), () {
        setState(() {
          this.title = title;
          this.message = message;
          this.type = type;
          this.payload = payload ?? null;
        });
        _animationController.forward();
        if (delay != null) {
          _timer = Timer(Duration(milliseconds: delay), () {
            _animationController.reverse();
          });
        }
      });
    } else {
      setState(() {
        this.title = title;
        this.message = message;
        this.type = type;
        this.payload = payload ?? null;
      });
      _animationController.forward();
      if (delay != null) {
        _timer = Timer(Duration(milliseconds: delay), () {
          _animationController.reverse();
        });
      }
    }
  }

  hide() {
    cancelTimer();
    _animationController.reverse();
  }

  cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  cancelTimerRelay() {
    if (_timerRelay != null) {
      _timerRelay.cancel();
    }
  }

  onPress() {
    cancelTimer();
    hide();
    if (widget.onTap != null) {
      widget.onTap(this.payload, this.type);
    }
    if (_controller.getTabListener() != null) {
      _controller.getTabListener()(this.payload, this.type);
    }
  }

  String getIconUri(TypeAlert type) {
    switch (type) {
      case TypeAlert.success:
        return widget.successImage ?? null;
      case TypeAlert.warning:
        return widget.warningImage ?? null;
      case TypeAlert.error:
        return widget.errorImage ?? null;
      default:
        return null;
    }
  }

  IconData getIcon(TypeAlert type) {
    switch (type) {
      case TypeAlert.success:
        return Icons.check;
      case TypeAlert.warning:
        return Icons.warning_amber_outlined;
      case TypeAlert.error:
        return Icons.error_outline;
      default:
        return null;
    }
  }

  Color getBackground(TypeAlert type) {
    switch (type) {
      case TypeAlert.success:
        return widget.successBackground ?? Colors.green;
      case TypeAlert.warning:
        return widget.warningBackground ?? Color(0xFFCE863D);
      case TypeAlert.error:
        return widget.errorBackground ?? Colors.red;
      default:
        return Colors.green;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller = null;
    _timer.cancel();
    _timerRelay.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
        .merge(widget.titleStyle);
    final contentStyle =
        TextStyle(color: Colors.white).merge(widget.contentStyle);
    String iconUri = getIconUri(this.type ?? null);
    return AnimatedBuilder(
      animation: _animationController,
      builder: (c, v) => Positioned(
        top: _animationPush.value,
        child: GestureDetector(
          onVerticalDragStart: (data) => hide(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              color: getBackground(this.type ?? null),
              padding: EdgeInsets.only(top: 36, bottom: 18, left: 12, right: 12),
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), side: BorderSide.none),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    iconUri != null
                        ? Image.asset(
                      iconUri,
                      fit: BoxFit.contain,
                      height: 30,
                      width: 30,
                    )
                        : Icon(
                      getIcon(this.type ?? null),
                      color: Colors.white,
                      size: 34,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.title ?? '',
                              style: titleStyle,
                              maxLines: widget.maxLinesTitle,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              this.message ?? '',
                              style: contentStyle,
                              maxLines: widget.maxLinesContent,
                            )
                          ],
                        ))
                  ],
                ),
              ),
              onPressed: onPress,
            ),
          ),
        ),
      ),
    );
  }
}
