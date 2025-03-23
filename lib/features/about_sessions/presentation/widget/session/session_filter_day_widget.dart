import 'package:flutter/material.dart';
import 'package:vinemas_v1/core/config/app_color.dart';

class SessionFilterDayWidget extends StatefulWidget {
  final Function(DateTime, String) onFilterChanged;

  const SessionFilterDayWidget({super.key, required this.onFilterChanged});

  @override
  State<SessionFilterDayWidget> createState() => _SessionFilterDayWidgetState();
}

class _SessionFilterDayWidgetState extends State<SessionFilterDayWidget> {
  int currentIndex = 0;
  int selectedInterval = 0;

  final List<Map<String, String>> daySchedule = List.generate(7, (index) {
    DateTime date = DateTime.now().add(Duration(days: index));

    List<String> weekdays = [
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
      'CN'
    ];

    return {
      'day': '${date.day}',
      'weekday': index == 0 ? 'H.nay' : weekdays[date.weekday - 1]
    };
  });

  final List<String> timeInterval = [
    'Tất cả',
    '00:00 - 03:00',
    '03:00 - 06:00',
    '06:00 - 09:00',
    '09:00 - 12:00',
    '12:00 - 15:00',
    '15:00 - 18:00',
    '18:00 - 21:00',
    '21:00 - 24:00'
  ];

  List<String> getFilteredTimeIntervals() {
    DateTime now = DateTime.now();
    DateTime selectedDate = DateTime.now().add(Duration(days: currentIndex));

    if (selectedDate.day == now.day &&
        selectedDate.month == now.month &&
        selectedDate.year == now.year) {
      int currentHour = now.hour;
      return timeInterval.where((interval) {
        if (interval == 'Tất cả') return true;
        List<String> parts = interval.split(' - ');
        int startHour = int.parse(parts[1].split(':')[0]);
        return startHour >= currentHour;
      }).toList();
    }

    return timeInterval;
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredTimeIntervals = getFilteredTimeIntervals();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      color: AppColor.secondaryColor,
      child: Column(
        children: [
          // Chọn ngày
          SizedBox(
            height: 54,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daySchedule.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                  DateTime selectedDate =
                      DateTime.now().add(Duration(days: index));
                  widget.onFilterChanged(
                      selectedDate, timeInterval[selectedInterval]);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? AppColor.buttonLinerOneColor
                        : AppColor.accentColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 42,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColor.secondaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          daySchedule[index]['weekday'] ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: currentIndex == index
                                      ? AppColor.buttonLinerOneColor
                                      : AppColor.primaryTextColor),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        alignment: Alignment.center,
                        child: Text('0${daySchedule[index]['day']}',
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          // Chọn khoảng thời gian
          SizedBox(
            height: 24,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredTimeIntervals.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    selectedInterval = index;
                  });
                  DateTime selectedDate =
                      DateTime.now().add(Duration(days: currentIndex));
                  widget.onFilterChanged(
                      selectedDate, filteredTimeIntervals[selectedInterval]);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: index == selectedInterval
                        ? AppColor.buttonLinerOneColor
                        : AppColor.accentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    filteredTimeIntervals[index],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
