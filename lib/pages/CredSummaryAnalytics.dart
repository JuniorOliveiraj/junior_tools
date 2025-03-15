import 'package:fl_chart/fl_chart.dart';
import 'package:junior_tools/theme/FontSize.dart';
import 'package:junior_tools/theme/colors.dart';
import 'package:junior_tools/theme/export_boiler_plate.dart';
import 'package:junior_tools/theme/fonts.dart';
import 'package:junior_tools/theme/textstyles.dart';


class CredSummaryAnalyticsView extends StatefulWidget {
  const CredSummaryAnalyticsView({Key? key, required BuildContext context})
      : super(key: key);

  @override
  _CredSummaryAnalyticsViewState createState() =>
      _CredSummaryAnalyticsViewState();
}

class _CredSummaryAnalyticsViewState extends State<CredSummaryAnalyticsView>
    with SingleTickerProviderStateMixin {
  String _selectedDateFrame = 'Last 12 months';
  final List<String> _dateFrames = [
    'Last 3 months',
    'Last 6 months',
    'Last 12 months',
    'This year'
  ];
  late AnimationController _animationController;
  late Animation<double> _animation;
  String _searchQuery = '';
  bool _isSearching = false;

  final List<Map<String, dynamic>> _categories = [
    {'title': 'Fuel', 'amount': '₹30,911', 'icon': Icons.local_gas_station},
    {'title': 'Food', 'amount': '₹25,450', 'icon': Icons.restaurant},
    {'title': 'Shopping', 'amount': '₹18,720', 'icon': Icons.shopping_cart},
    {'title': 'Entertainment', 'amount': '₹12,300', 'icon': Icons.movie},
    {'title': 'Travel', 'amount': '₹22,150', 'icon': Icons.flight},
    {'title': 'Others', 'amount': '₹15,386', 'icon': Icons.more_horiz},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'your spends summary',
          style: KCustomTextStyle.kMedium(
            context,
            FontSize.Medium.value,
            KConstantColors.whiteColor,
            KConstantFonts.geistMedium,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search,
                color: Colors.white),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (_isSearching) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                  _searchQuery = '';
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalSpending(context),
            _buildDateFrameDropdown(context),
            _buildSpendingChart(context),
            SizeTransition(
              sizeFactor: _animation,
              child: _buildSearchField(context),
            ),
            _buildCategorySplit(context),
            _buildShowTransactionsButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSpending(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOTAL IN MAR \'24',
            style: KCustomTextStyle.kMedium(
              context,
              FontSize.Medium.value,
              Colors.grey,
              KConstantFonts.geistMedium,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '₹1,097.47',
                style: KCustomTextStyle.kMedium(
                  context,
                  FontSize.Medium.value,
                  KConstantColors.whiteColor,
                  KConstantFonts.geistMedium,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '↓ ₹5,196.84 from last month',
                style: KCustomTextStyle.kMedium(
                  context,
                  FontSize.Medium.value,
                  Colors.green,
                  KConstantFonts.geistMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '12 MONTH SUMMARY',
            style: KCustomTextStyle.kMedium(
              context,
              FontSize.Medium.value,
              Colors.grey,
              KConstantFonts.geistMedium,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '₹54,542',
            style: KCustomTextStyle.kMedium(
              context,
              FontSize.Medium.value,
              KConstantColors.whiteColor,
              KConstantFonts.geistMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateFrameDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButton<String>(
        value: _selectedDateFrame,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        iconSize: 24,
        elevation: 16,
        style: KCustomTextStyle.kMedium(
          context,
          FontSize.Medium.value,
          KConstantColors.whiteColor,
          KConstantFonts.geistMedium,
        ),
        dropdownColor: Colors.black,
        onChanged: (String? newValue) {
          setState(() {
            _selectedDateFrame = newValue!;
            _animationController.forward(from: 0.0);
          });
        },
        items: _dateFrames.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSpendingChart(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 14000,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      const titles = [
                        'A',
                        'M',
                        'J',
                        'J',
                        'A',
                        'S',
                        'O',
                        'N',
                        'D',
                        'J',
                        'F',
                        'M'
                      ];
                      return Text(
                        titles[value.toInt()],
                        style: KCustomTextStyle.kMedium(
                          context,
                          FontSize.Medium.value,
                          Colors.grey,
                          KConstantFonts.geistMedium,
                        ),
                      );
                    },
                    reservedSize: 30,
                  ),
                ),
                leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(
                      toY: 12000 * _animation.value, color: Colors.white)
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(
                      toY: 10000 * _animation.value, color: Colors.white)
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(
                      toY: 4000 * _animation.value, color: Colors.white)
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(
                      toY: 6000 * _animation.value, color: Colors.white)
                ]),
                BarChartGroupData(x: 4, barRods: [
                  BarChartRodData(
                      toY: 5000 * _animation.value, color: Colors.white)
                ]),
                BarChartGroupData(x: 5, barRods: [
                  BarChartRodData(
                      toY: 4000 * _animation.value, color: Colors.white)
                ]),
                BarChartGroupData(x: 6, barRods: [
                  BarChartRodData(
                      toY: 2000 * _animation.value, color: Colors.white)
                ]),
                BarChartGroupData(x: 7, barRods: [
                  BarChartRodData(
                      toY: 8000 * _animation.value, color: Colors.white)
                ]),
                BarChartGroupData(x: 8, barRods: [
                  BarChartRodData(
                      toY: 4000 * _animation.value, color: Colors.white)
                ]),
                BarChartGroupData(x: 9, barRods: [
                  BarChartRodData(
                      toY: 7000 * _animation.value, color: Colors.white)
                ]),
                BarChartGroupData(x: 10, barRods: [
                  BarChartRodData(
                      toY: 6000 * _animation.value, color: Colors.white)
                ]),
                BarChartGroupData(x: 11, barRods: [
                  BarChartRodData(
                      toY: 1000 * _animation.value, color: Colors.white)
                ]),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        style: KCustomTextStyle.kMedium(
          context,
          FontSize.Medium.value,
          KConstantColors.whiteColor,
          KConstantFonts.geistMedium,
        ),
        decoration: InputDecoration(
          hintText: 'Search categories',
          hintStyle: KCustomTextStyle.kMedium(
            context,
            FontSize.Medium.value,
            Colors.grey,
            KConstantFonts.geistMedium,
          ),
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
      ),
    );
  }

  Widget _buildCategorySplit(BuildContext context) {
    List<Map<String, dynamic>> filteredCategories = _categories
        .where((category) =>
            category['title'].toLowerCase().contains(_searchQuery))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '12 MONTH CATEGORY SPLIT',
            style: KCustomTextStyle.kMedium(
              context,
              FontSize.Medium.value,
              Colors.grey,
              KConstantFonts.geistMedium,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: filteredCategories.length,
            itemBuilder: (context, index) {
              return _buildCategoryItem(
                context,
                filteredCategories[index]['title'],
                filteredCategories[index]['amount'],
                filteredCategories[index]['icon'],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
      BuildContext context, String title, String amount, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            title,
            style: KCustomTextStyle.kMedium(
              context,
              FontSize.Medium.value,
              KConstantColors.whiteColor,
              KConstantFonts.geistMedium,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: KCustomTextStyle.kMedium(
              context,
              FontSize.Medium.value,
              KConstantColors.whiteColor,
              KConstantFonts.geistMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowTransactionsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Show transactions',
          style: KCustomTextStyle.kMedium(
            context,
            FontSize.Medium.value,
            Colors.black,
            KConstantFonts.geistMedium,
          ),
        ),
      ),
    );
  }
}
