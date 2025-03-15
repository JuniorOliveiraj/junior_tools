import 'package:fl_chart/fl_chart.dart';
import 'package:junior_tools/theme/FontSize.dart';
import 'package:junior_tools/theme/colors.dart';
import 'package:junior_tools/theme/dimensions.dart';
import 'package:junior_tools/theme/export_boiler_plate.dart';
import 'package:junior_tools/theme/fonts.dart';
import 'package:junior_tools/theme/textstyles.dart';

class ActivityAnalyticsView extends StatefulWidget {
  const ActivityAnalyticsView({super.key});

  @override
  State<ActivityAnalyticsView> createState() => _ActivityAnalyticsViewState();
}

class _ActivityAnalyticsViewState extends State<ActivityAnalyticsView> {
  String _selectedPeriod = 'Week';
  final List<String> _periods = ['Week', 'Month', 'Year', 'All Time'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                vSizedBox2,
                _buildPeriodSelector(context),
                _buildWeekSection(context),
                _buildActivityChart(context),
                _buildSummary(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          Container(
            child: Stack(
              children: [
                Center(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Iconsax.send),
          const SizedBox(width: 16),
          const Icon(Iconsax.add),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            'Activities',
            style: KCustomTextStyle.kBold(
              context,
              FontSize.header.value + 6,
              KConstantColors.bgColor,
              KConstantFonts.helveticaBold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children:
                _periods.map((period) {
                  final isSelected = period == _selectedPeriod;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedPeriod = period),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        period,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'This Week',
                style: KCustomTextStyle.kMedium(
                  context,
                  FontSize.Medium.value,
                  KConstantColors.bgColor,
                  KConstantFonts.helveticaMedium,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.orange),
            ],
          ),
          Text(
            'Last Week · 0m',
            style: KCustomTextStyle.kMedium(
              context,
              FontSize.Medium.value,
              KConstantColors.faintBgColor,
              KConstantFonts.helveticaMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityChart(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          maxY: 40,
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 30,
                  width: 40,
                  color: Colors.deepOrange[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
                BarChartRodData(
                  toY: 15,
                  width: 40,
                  color: Colors.deepOrange[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
                BarChartRodData(
                  toY: 32,
                  width: 40,
                  color: Colors.deepOrange[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
                BarChartRodData(
                  toY: 20,
                  width: 40,
                  color: Colors.deepOrange[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
                BarChartRodData(
                  toY: 30,
                  width: 40,
                  color: Colors.deepOrange[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
                BarChartRodData(
                  toY: 26,
                  width: 40,
                  color: Colors.deepOrange[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
                BarChartRodData(
                  toY: 14,
                  width: 40,
                  color: Colors.deepOrange[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
                BarChartRodData(
                  toY: 10,
                  width: 40,
                  color: Colors.deepOrange[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
              ],
            ),
            ...List.generate(
              5,
              (index) => BarChartGroupData(x: index + 1, barRods: []),
            ),
          ],
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 7,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey[200],
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            },
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 7,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: KCustomTextStyle.kMedium(
                      context,
                      FontSize.Medium.value,
                      KConstantColors.bgColor,
                      KConstantFonts.helveticaMedium,
                    ),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = [
                    'Today',
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                  ];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      days[value.toInt()],
                      style: KCustomTextStyle.kMedium(
                        context,
                        FontSize.Medium.value - 2,
                        KConstantColors.faintWhiteColor,
                        KConstantFonts.helveticaMedium,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vSizedBox2,
          Text(
            'SUMMARY FOR 2 ACTIVITIES',
            style: KCustomTextStyle.kBold(
              context,
              FontSize.Medium.value,
              KConstantColors.faintBgColor,
              KConstantFonts.helveticaMedium,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.6,
            children: [
              _buildSummaryCard(
                context,
                'Duration',
                '30',
                'm',
                Colors.deepOrange[300]!,
                Colors.deepOrange[50]!,
              ),
              _buildSummaryCard(
                context,
                'Active Energy',
                '0',
                'kcal',
                Colors.grey[800]!,
                Colors.grey[100]!,
              ),
              _buildSummaryCard(
                context,
                'Distance',
                '1',
                'mi',
                Colors.grey[800]!,
                Colors.grey[100]!,
              ),
              _buildSummaryCard(
                context,
                'Elevation Gain',
                '0',
                'ft',
                Colors.grey[800]!,
                Colors.grey[100]!,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    String unit,
    Color textColor,
    Color backgroundColor,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: KCustomTextStyle.kMedium(
                context,
                FontSize.Medium.value,
                KConstantColors.faintBgColor,
                KConstantFonts.helveticaMedium,
              ),
            ),
            vSizedBox0,
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: KCustomTextStyle.kBold(
                    context,
                    FontSize.Medium.value + 8,
                    KConstantColors.bgColor,
                    KConstantFonts.helveticaMedium,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: KCustomTextStyle.kMedium(
                    context,
                    FontSize.Medium.value,
                    KConstantColors.bgColor,
                    KConstantFonts.helveticaMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
