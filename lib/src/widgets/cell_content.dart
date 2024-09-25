// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../customization/calendar_builders.dart';
import '../customization/calendar_style.dart';

class CellContent extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final dynamic locale;
  final bool isTodayHighlighted;
  final bool isToday;
  final bool isSelected;
  final bool isRangeStart;
  final bool isRangeEnd;
  final bool isWithinRange;
  final bool isOutside;
  final bool isDisabled;
  final bool isHoliday;
  final bool isWeekend;
  final CalendarStyle calendarStyle;
  final CalendarBuilders calendarBuilders;
  final Map<String, dynamic> holidayMapInfo;

  const CellContent({
    Key? key,
    required this.day,
    required this.focusedDay,
    required this.calendarStyle,
    required this.calendarBuilders,
    required this.isTodayHighlighted,
    required this.isToday,
    required this.isSelected,
    required this.isRangeStart,
    required this.isRangeEnd,
    required this.isWithinRange,
    required this.isOutside,
    required this.isDisabled,
    required this.isHoliday,
    required this.isWeekend,
    required this.holidayMapInfo,
    this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dowLabel = DateFormat.EEEE(locale).format(day);
    final dayLabel = DateFormat.yMMMMd(locale).format(day);
    final semanticsLabel = '$dowLabel, $dayLabel';

    Widget? cell =
        calendarBuilders.prioritizedBuilder?.call(context, day, focusedDay);

    if (cell != null) {
      return Semantics(
        label: semanticsLabel,
        excludeSemantics: true,
        child: cell,
      );
    }

    final text =
        calendarStyle.dayTextFormatter?.call(day, locale) ?? '${day.day}';
    final margin = calendarStyle.cellMargin;
    final padding = calendarStyle.cellPadding;
    final alignment = calendarStyle.cellAlignment;
    final duration = const Duration(milliseconds: 250);

    final subText = holidayMapInfo['lunarDay'];

    final isHolidayTarget = holidayMapInfo['isHolidayTarget'];

    if (isDisabled) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.disabledDecoration,
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(text, style: calendarStyle.disabledTextStyle),
                SizedBox(height: 2,),
                Text(subText, style: calendarStyle.disabledSubTextStyle)
              ],
            ),
          );
    } else if (isSelected) {
      cell = calendarBuilders.selectedBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.selectedDecoration,
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(text, style: calendarStyle.selectedTextStyle),
                SizedBox(height: 2,),
                Text(subText, style: calendarStyle.selectedSubTextStyle)
              ],
            ),
          );
    } else if (isRangeStart) {
      cell =
          calendarBuilders.rangeStartBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                padding: padding,
                decoration: calendarStyle.rangeStartDecoration,
                alignment: alignment,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(text, style: calendarStyle.rangeStartTextStyle),
                    SizedBox(height: 2,),
                    Text(subText, style: calendarStyle.rangeStartSubTextStyle)
                  ],
                ),
              );
    } else if (isRangeEnd) {
      cell = calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.rangeEndDecoration,
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(text, style: calendarStyle.rangeEndTextStyle),
                SizedBox(height: 2,),
                Text(subText, style: calendarStyle.rangeEndSubTextStyle)
              ],
            ),
          );
    } else if (isToday && isTodayHighlighted) {
      cell = calendarBuilders.todayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.todayDecoration,
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(text, style: calendarStyle.todayTextStyle),
                SizedBox(height: 2,),
                Text(subText, style: calendarStyle.todaySubTextStyle)
              ],
            ),
          );
    } else if (isHoliday) {
      cell = calendarBuilders.holidayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.holidayDecoration,
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(text, style: calendarStyle.holidayTextStyle),
                SizedBox(height: 2,),
                Text(subText, style: calendarStyle.holidaySubTextStyle)
              ],
            ),
          );
    } else if (isWithinRange) {
      cell =
          calendarBuilders.withinRangeBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                padding: padding,
                decoration: calendarStyle.withinRangeDecoration,
                alignment: alignment,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(text, style: calendarStyle.withinRangeTextStyle),
                    SizedBox(height: 2,),
                    Text(subText, style: calendarStyle.withinRangeSubTextStyle)
                  ],
                ),
              );
    } else if (isOutside) {
      cell = calendarBuilders.outsideBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.outsideDecoration,
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(text, style: calendarStyle.outsideTextStyle),
                SizedBox(height: 2,),
                Text(subText, style: calendarStyle.outsideSubTextStyle)
              ],
            ),
          );
    } else {
      cell = calendarBuilders.defaultBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: isWeekend
                ? calendarStyle.weekendDecoration
                : calendarStyle.defaultDecoration,
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: isWeekend
                      ? calendarStyle.weekendTextStyle
                      : calendarStyle.defaultTextStyle,
                ),
                SizedBox(height: 2,),
                Text(
                  subText,
                  style: isHolidayTarget ? calendarStyle.defaultHolidayTextStyle : isWeekend
                      ? calendarStyle.weekendSubTextStyle
                      : calendarStyle.defaultSubTextStyle,
                )
              ],
            ),
          );
    }

    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: cell,
    );
  }
}
