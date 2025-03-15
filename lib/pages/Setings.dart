import 'package:junior_tools/Components/ModernListTile.dart';
import 'package:junior_tools/Components/ModernTextField.dart';
import 'package:junior_tools/pages/ActivityAnalyticsView.dart';
import 'package:junior_tools/pages/LigarPc.dart';
import 'package:junior_tools/theme/FontSize.dart';
import 'package:junior_tools/theme/colors.dart';
import 'package:junior_tools/theme/export_boiler_plate.dart';
import 'package:junior_tools/theme/fonts.dart';
import 'package:junior_tools/theme/textstyles.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  _AppSettingsScreenState createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen>
    with SingleTickerProviderStateMixin {
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredItems = [];
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _filteredItems = _getAllItems();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getAllItems() {
    return [
      {'title': 'Ligar meu pc', 'icon': Icons.power_settings_new, 'section': 'MANUTENÇÃO', 'page': LigarPc(),},
      {
        'title': 'Guidelines',
        'icon': Icons.policy_outlined,
        'section': 'MANUTENÇÃO',
        
      },
      {
        'title': 'Contact team Peanut',
        'icon': Icons.mail_outline,
        'section': 'MANUTENÇÃO',
        
      },
      {
        'title': 'Restore purchases',
        'icon': Icons.restore,
        'section': 'MANUTENÇÃO',
        
      },
      {
        'title': 'Manage Subscription',
        'icon': Icons.subscriptions_outlined,
        'section': 'SUBSCRIPTION',
        
      },
      {
        'title': 'Notification settings',
        'icon': Icons.notifications_outlined,
        'section': 'SETTINGS',
        
      },
      {
        'title': 'Discovery settings',
        'icon': Icons.explore_outlined,
        'section': 'SETTINGS',
        
      },
      {
        'title': 'Feed settings',
        'icon': Icons.dynamic_feed_outlined,
        'section': 'SETTINGS',
        
      },
      {
        'title': 'Dark mode',
        'icon': Icons.dark_mode_outlined,
        'section': 'SETTINGS',
        'value': 'Automatic',
        
      },
      {
        'title': 'Widgets',
        'icon': Icons.widgets_outlined,
        'section': 'SETTINGS',
        
      },
      {
        'title': 'Invite friends',
        'icon': Icons.person_add_outlined,
        'section': 'SPREAD THE WORD',
        
      },
      {
        'title': 'Rate us on the App Store',
        'icon': Icons.star_outline,
        'section': 'SPREAD THE WORD',
        
      },
    ];
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _getAllItems();
      } else {
        _filteredItems =
            _getAllItems()
                .where(
                  (item) =>
                      item['title'].toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Settings',
        style: KCustomTextStyle.kMedium(
          context,
          FontSize.Medium.value,
          Theme.of(context).textTheme.headlineLarge?.color ?? Colors.black,
          KConstantFonts.geistMedium,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(_isSearchVisible ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              _isSearchVisible = !_isSearchVisible;
              if (_isSearchVisible) {
                _animationController.forward();
              } else {
                _animationController.reverse();
                _searchController.clear();
                _filterItems('');
              }
            });
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: ListView(
            children: [
              _buildSection(context, 'MANUTENÇÃO'),
              _buildSection(context, 'SUBSCRIPTION'),
              _buildSection(context, 'SETTINGS'),
              _buildSection(context, 'SPREAD THE WORD'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return SizeTransition(
      sizeFactor: _animation,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ModernTextField(
          controller: _searchController,
          hintText: 'Search settings',
          prefixIcon: const Icon(Icons.search),
          onChanged: _filterItems,
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title) {
    List<Map<String, dynamic>> sectionItems =
        _filteredItems.where((item) => item['section'] == title).toList();

    if (sectionItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: KCustomTextStyle.kMedium(
              context,
              FontSize.Small.value,
              Theme.of(context).textTheme.headlineLarge?.color ?? Colors.black,
              KConstantFonts.geistMedium,
            ),
          ),
        ),
        ...sectionItems.map(
          (item) => _buildListItem(
            context,
            item['title'],
            item['icon'],
            page: item['page'],
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(
    BuildContext context,
    String title,
    IconData icon, {
    Widget? page,
  }) {
    return ModernListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: KCustomTextStyle.kMedium(
          context,
          FontSize.Medium.value,
          Theme.of(context).textTheme.headlineLarge?.color ?? Colors.black,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
    );
  }
}
