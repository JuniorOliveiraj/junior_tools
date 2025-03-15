import 'package:animate_do/animate_do.dart';
import 'package:junior_tools/Components/home/ListGastos.dart';
import 'package:junior_tools/Components/home/Menu.dart';
import 'package:junior_tools/pages/ActivityAnalyticsView.dart';
import 'package:junior_tools/pages/CredSummaryAnalytics.dart';
import 'package:junior_tools/pages/Setings.dart';
import 'package:junior_tools/store/banking/gastosTotal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:junior_tools/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.setThemeDark}) : super(key: key);

  final void Function(bool) setThemeDark;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  bool _isScrolled = false;
  String _totalGastos = "Carregando...";

  void fetchTotalGastos() async {
    Transaction transaction = await TransactionTotal().getTransactions();
    if (mounted) {
      setState(() {
        _totalGastos = transaction.total.toString();
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    fetchTotalGastos();
    super.initState();
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 100.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AdvancedDrawer(
      backdropColor: Theme.of(context).colorScheme.onBackground,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onBackground,
            blurRadius: 20.0,
            spreadRadius: 5.0,
            offset: Offset(-20.0, 0.0),
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      drawer: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80.0,
                  height: 80.0,
                  margin: EdgeInsets.only(left: 20, top: 24.0),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/avatar-1.png'),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    "John Doe",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(),
                Divider(color: Colors.grey.shade800),
                ListTile(
                  onTap: () {},
                  leading: Icon(Iconsax.home),
                  title: Text('Dashboard'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActivityAnalyticsView(),
                      ),
                    );
                  },
                  leading: Icon(Iconsax.chart_2),
                  title: Text('Analytics'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Iconsax.profile_2user),
                  title: Text('Contacts'),
                ),
                SizedBox(height: 50),
                Divider(color: Colors.grey.shade800),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppSettingsScreen(),
                      ),
                    );
                  },
                  leading: Icon(Iconsax.setting_2),
                  title: Text('Settings'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                CredSummaryAnalyticsView(context: context),
                      ),
                    );
                  },
                  leading: Icon(Iconsax.support),
                  title: Text('Support'),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor:
            !isDarkMode
                ? Theme.of(context).colorScheme.onSecondary
                : const Color.fromARGB(255, 28, 27, 27),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 250.0,
              elevation: 0,
              pinned: true,
              stretch: true,
              toolbarHeight: 80,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: IconButton(
                color: Theme.of(context).colorScheme.onSurface,
                onPressed: _handleMenuButtonPressed,
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: Icon(
                        value.visible ? Iconsax.close_square : Iconsax.menu,
                        key: ValueKey<bool>(value.visible),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Iconsax.notification,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    isDarkMode ? Iconsax.sun : Iconsax.moon,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.setThemeDark(!isDarkMode);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Iconsax.more,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {},
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              centerTitle: true,
              title: AnimatedOpacity(
                opacity: _isScrolled ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Text(
                      '\$ ${_totalGastos}',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 30,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                titlePadding: const EdgeInsets.only(left: 20, right: 20),
                title: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _isScrolled ? 0.0 : 1.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FadeIn(
                        duration: const Duration(milliseconds: 400),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.5),
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(width: 3),
                            Text(
                              '${_totalGastos}',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: MaterialButton(
                          height: 30,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Add Money',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.9),
                              fontSize: 10,
                            ),
                          ),
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 30,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),

            Menu(),
            ListGastos(),
          ],
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
