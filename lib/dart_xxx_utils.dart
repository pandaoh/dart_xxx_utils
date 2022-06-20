// ignore_for_file: prefer_function_declarations_over_variables, prefer_typing_uninitialized_variables

/*
 * @Author: HxB
 * @Date: 2022-06-20 13:59:25
 * @LastEditors: DoubleAm
 * @LastEditTime: 2022-06-20 14:59:51
 * @Description: xxx 工具类
 * @FilePath: \dart_xxx_utils\lib\dart_xxx_utils.dart
 */
library dart_xxx_utils;

import 'dart:async';

import 'dart:convert';

class XxxUtils {
  XxxUtils._internal() {
    /// 构建单例。
  }
  static final XxxUtils _instance = XxxUtils._internal();

  /// 防抖节流处理
  static Function debounce(
    Function func, [
    int delay = 2000,
  ]) {
    var timer;
    Function target = () {
      if (timer != null) {
        timer.cancel();
      }
      timer = Timer(Duration(milliseconds: delay), () {
        func.call();
      });
    };
    return target;
  }

  static Function throttle(
    Function func, [
    int delay = 2000,
  ]) {
    bool enable = true;
    Function target = () async {
      if (enable == true) {
        enable = false;
        func.call();
        await Future.delayed(Duration(milliseconds: delay));
        enable = true;
      }
    };
    return target;
  }

  /// 加密解密处理
  static String base64Encode(String data) {
    var content = utf8.encode(data);
    var base64String = base64.encode(content);
    return base64String;
  }

  static String base64Decode(String data) {
    var content = base64.decode(data);
    var result = utf8.decode(content);
    return result;
  }

  /// 时间处理
  static String dateFormat(DateTime time, {String format = "yyyy-mm-dd hh:ii:ss"}) {
    var dateObj = {
      'm+': time.month, //月份
      'd+': time.day, //日
      'h+': time.hour, //小时
      'i+': time.minute, //分
      's+': time.second, //秒
    };
    RegExp yearReg = RegExp(r"(y+)");
    if (yearReg.hasMatch(format)) {
      var matches = yearReg.allMatches(format);
      var match = "${matches.elementAt(0).group(1)}";
      format = format.replaceAll(match, "${time.year}".substring(4 - match.length));
    }
    dateObj.forEach((key, value) {
      RegExp replaceReg = RegExp(r'(' + "$key" + ')');
      if (replaceReg.hasMatch(format)) {
        var matches = replaceReg.allMatches(format);
        var match = "${matches.elementAt(0).group(1)}";
        format = format.replaceAll(match, (match.length == 1) ? "$value" : "00$value".substring("$value".length));
      }
    });
    return format;
  }

  static String timeSince(DateTime date, {bool long = false, formater = "yyyy-mm-dd hh:ii:ss"}) {
    DateTime now = DateTime.now();
    if (now.isBefore(date)) {
      return dateFormat(date, format: formater);
    }
    var interval = now.difference(date);
    if (long) {
      int months = interval.inDays ~/ 30; // 向下取整，Dart 独有运算符。
      if (months >= 4) {
        return dateFormat(date, format: formater);
      }
      if (months >= 1) {
        return "$months 月前";
      }
      int weeks = interval.inDays ~/ 7;
      if (weeks >= 1) {
        return "$weeks 周前";
      }
    }
    if (interval.inDays >= 8) {
      return dateFormat(date, format: formater);
    }
    if (interval.inDays >= 1) {
      return "${interval.inDays} 天前";
    }
    if (interval.inHours >= 1) {
      return "${interval.inHours} 小时前";
    }
    if (interval.inMinutes >= 1) {
      return "${interval.inMinutes} 分钟前";
    }
    return "刚刚";
  }

  /// 数据结构处理
  static Map arr2Map(List arr, String key) {
    var obj = {};
    for (var d in arr) {
      obj[d[key]] = d;
    }
    return obj;
  }

  /// 文件(目录结构、创建、读写)处理
  /// 日志处理
  /// 本地缓存读写处理
  /// 数学问题(小数、浮点数正则、加减乘除等)处理
  /// 字符串(判断 JSON、UUID、TimeCode等)处理
}
