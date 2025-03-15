 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:junior_tools/theme/FontSize.dart';
import 'package:junior_tools/theme/colors.dart';
import 'package:junior_tools/theme/fonts.dart';
import 'package:junior_tools/theme/textstyles.dart';
 

class DailyGoalsScreen extends StatefulWidget {
  const DailyGoalsScreen({Key? key}) : super(key: key);

  @override
  _DailyGoalsScreenState createState() => _DailyGoalsScreenState();
}

class _DailyGoalsScreenState extends State<DailyGoalsScreen> {
  late DateTime selectedDate;
  late List<DateTime> weekDays;

  final Map<DateTime, List<Map<String, dynamic>>> _goalsPerDate = {};

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _initializeWeekDays();
    _initializeGoalsData();
  }

  void _initializeWeekDays() {
    final now = DateTime.now();
    weekDays = List.generate(
        7, (index) => now.subtract(Duration(days: now.weekday - 1 - index)));
  }

  void _initializeGoalsData() {
    for (var day in weekDays) {
      _goalsPerDate[day] = [
        {'title': 'Meditate', 'completed': day.day % 2 == 0},
        {'title': 'Read 30 pages', 'completed': day.day % 3 == 0},
        {'title': 'Exercise', 'completed': day.day % 4 == 0},
        {'title': 'Write in journal', 'completed': day.day % 5 == 0},
        {'title': 'Learn something new', 'completed': day.day % 6 == 0},
      ];

      // Add some variety to the goals for different days
      if (day.weekday == DateTime.monday) {
        _goalsPerDate[day]!.add({'title': 'Plan the week', 'completed': false});
      }
      if (day.weekday == DateTime.friday) {
        _goalsPerDate[day]!
            .add({'title': 'Review weekly progress', 'completed': false});
      }
      if (day.weekday == DateTime.saturday) {
        _goalsPerDate[day]!
            .add({'title': 'Relax and unwind', 'completed': true});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,// KConstantColors.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildWeekViewCalendar(context),
            Expanded(
              child: _buildGoalsList(context),
            ),
            _buildAddGoalButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final completedGoals = _goalsPerDate[selectedDate]
            ?.where((goal) => goal['completed'])
            .length ??
        0;
    final totalGoals = _goalsPerDate[selectedDate]?.length ?? 0;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily Goals',
                style: KCustomTextStyle.kMedium(
                  context,
                  FontSize.Medium.value,
                  Colors.black,//KConstantColors.blackColor,
                  KConstantFonts.geistMedium,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ],
          ),
          Text(
            'You\'ve completed $completedGoals out of $totalGoals goals',
            style: KCustomTextStyle.kMedium(
              context,
              FontSize.Medium.value,
              KConstantColors.faintBgColor,
              KConstantFonts.geistMedium,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: totalGoals > 0 ? completedGoals / totalGoals : 0,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekViewCalendar(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final day = weekDays[index];
          final isSelected = day.year == selectedDate.year &&
              day.month == selectedDate.month &&
              day.day == selectedDate.day;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = day;
              });
            },
            child: Container(
              width: 50,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ['M', 'T', 'W', 'T', 'F', 'S', 'S'][day.weekday - 1],
                    style: KCustomTextStyle.kMedium(
                      context,
                      FontSize.Small.value,
                      isSelected ? Colors.white : KConstantColors.faintBgColor,
                      KConstantFonts.geistMedium,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    day.day.toString(),
                    style: KCustomTextStyle.kMedium(
                      context,
                      FontSize.Medium.value,
                      isSelected ? Colors.white :Colors.black, // KConstantColors.blackColor,
                      KConstantFonts.geistMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGoalsList(BuildContext context) {
    final goals = _goalsPerDate[selectedDate] ?? [];

    if (goals.isEmpty) {
      return Center(
        child: Text(
          'No goals for this day',
          style: KCustomTextStyle.kMedium(
            context,
            FontSize.Medium.value,
            KConstantColors.faintBgColor,
            KConstantFonts.geistMedium,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final goal = goals[index];
        return _buildGoalItem(context, goal['title'], goal['completed']);
      },
    );
  }

  Widget _buildGoalItem(BuildContext context, String title, bool completed) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: completed ? Colors.blue : Colors.transparent,
              border: Border.all(color: completed ? Colors.blue : Colors.grey),
            ),
            child: completed
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: KCustomTextStyle.kMedium(
                context,
                FontSize.Medium.value,
                completed ? Colors.grey : Colors.black, // KConstantColors.blackColor,
                KConstantFonts.geistMedium,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAddGoalButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Add New Goal',
              style: KCustomTextStyle.kMedium(
                context,
                FontSize.Medium.value,
                Colors.white,
                KConstantFonts.geistMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
