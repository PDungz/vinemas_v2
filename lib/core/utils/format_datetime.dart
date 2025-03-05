import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class FormatDateTime {
  /// Format a DateTime to 'dd/MM/yyyy'
  static String formatToDDMMYYYY(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Format a DateTime to 'yyyy-MM-dd'
  static String formatToYYYYMMDD(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Format a DateTime to a human-readable string, e.g., 'January 1, 2025'
  static String formatToReadable(DateTime date) {
    return DateFormat('MMMM d, yyyy').format(date);
  }

  /// Format a DateTime to an abbreviated human-readable string, e.g., 'Jan 1, 2025'
  static String formatToAbbreviated(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  /// Format a DateTime to include time, e.g., 'dd/MM/yyyy HH:mm:ss'
  static String formatWithTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(date);
  }

  /// Format a DateTime to 'HH:mm:ss'
  static String formatToTime(DateTime date) {
    return DateFormat('HH:mm:ss').format(date);
  }

  /// Parse a string to DateTime from 'dd/MM/yyyy'
  static DateTime? parseFromDDMMYYYY(String dateString) {
    try {
      return DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing date: $e');
      }
      return null;
    }
  }

  /// Convert date string from 'yyyy-MM-dd' to 'dd/MM/yyyy'
  static String convertFromYYYYMMDDToDDMMYYYY(String dateString) {
    try {
      final date = DateFormat('yyyy-MM-dd').parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      if (kDebugMode) {
        print('Error converting date: $e');
      }
      return '';
    }
  }

  /// Convert minutes to 'HH:mm' format
  static String convertMinutesToHourMinute(int totalMinutes) {
    final int hours = totalMinutes ~/ 60;
    final int minutes = totalMinutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  /// Convert seconds to 'HH:mm:ss' format
  static String convertSecondsToHourMinuteSecond(int totalSeconds) {
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Format a DateTime to 'HH:mm'
  static String formatToHourMinute(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  /// Check if a date is in the past
  static bool isPastDate(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Check if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
