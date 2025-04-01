import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/constants/app_colors.dart';
import '../screens/material/add_item_screen.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String leftIconPath;
  final double leftIconWidth;
  final double leftIconHeight;
  final String? rightIconPath;
  final Widget? rightIcon;
  final double rightIconWidth;
  final double rightIconHeight;
  final VoidCallback? onRightIconTap;
  final double height;
  final Color backgroundColor;
  final double bottomPadding;
  final double horizontalPadding;

  const HeaderWidget({
    super.key,
    required this.title,
    required this.leftIconPath,
    this.leftIconWidth = 22,
    this.leftIconHeight = 22,
    this.rightIconPath,
    this.rightIcon,
    this.rightIconWidth = 14,
    this.rightIconHeight = 14,
    this.onRightIconTap,
    this.height = 91,
    this.backgroundColor = Colors.white,
    this.bottomPadding = 12.0,
    this.horizontalPadding = 19.0,
  }) : assert(rightIconPath != null || rightIcon != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      leftIconPath,
                      width: leftIconWidth,
                      height: leftIconHeight,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onRightIconTap,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.menuBorder,
                        width: 0.5,
                      ),
                    ),
                    child: Center(
                      child: rightIcon ??
                          SvgPicture.asset(
                            rightIconPath!,
                            width: rightIconWidth,
                            height: rightIconHeight,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchHeaderWidget extends StatefulWidget {
  final Function(String) onSearch;

  const SearchHeaderWidget({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<SearchHeaderWidget> createState() => _SearchHeaderWidgetState();
}

class _SearchHeaderWidgetState extends State<SearchHeaderWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 97, // Height from image
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF2F2F2),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 19), // Padding from image (19px)
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 36, // Size from image
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFD2D2D2),
                    width: 0.5,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Search Container - flexible width
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 36, // Height from image
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F0FC),
                    borderRadius: BorderRadius.circular(82),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(
                          Icons.search,
                          size: 14,
                          color: Color(0xFFABAFB1),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(
                            fontFamily: 'Metropolis',
                            fontSize: 12,
                            letterSpacing: -0.12,
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Search by item name',
                            hintStyle: TextStyle(
                              fontFamily: 'Metropolis',
                              fontSize: 12,
                              letterSpacing: -0.12,
                              color: Color(0xFFABAFB1),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            isDense: true,
                          ),
                          onChanged: (value) {
                            widget.onSearch(value);
                          },
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(
                            Icons.clear,
                            size: 14,
                            color: Color(0xFFABAFB1),
                          ),
                          onPressed: () {
                            _searchController.clear();
                            widget.onSearch('');
                          },
                          constraints: const BoxConstraints(
                            minWidth: 30,
                            minHeight: 30,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Voice icon container
            Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD2D2D2),
                  width: 0.5,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/svgs/mic_icon.svg',
                  width: 12,
                  height: 14,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF695CFF),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// New class that includes the Add New Item button
class SearchHeaderWithAddButton extends StatefulWidget {
  final Function(String) onSearch;

  const SearchHeaderWithAddButton({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<SearchHeaderWithAddButton> createState() =>
      _SearchHeaderWithAddButtonState();
}

class _SearchHeaderWithAddButtonState extends State<SearchHeaderWithAddButton> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 97, // Height from image
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF2F2F2),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 19), // Padding from image (19px)
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 36, // Size from image
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFD2D2D2),
                    width: 0.5,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Search Container - flexible width
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 36, // Height from image
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F0FC),
                    borderRadius: BorderRadius.circular(82),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(
                          Icons.search,
                          size: 14,
                          color: Color(0xFFABAFB1),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(
                            fontFamily: 'Metropolis',
                            fontSize: 12,
                            letterSpacing: -0.12,
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Search by item name',
                            hintStyle: TextStyle(
                              fontFamily: 'Metropolis',
                              fontSize: 12,
                              letterSpacing: -0.12,
                              color: Color(0xFFABAFB1),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            isDense: true,
                          ),
                          onChanged: (value) {
                            widget.onSearch(value);
                          },
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(
                            Icons.clear,
                            size: 14,
                            color: Color(0xFFABAFB1),
                          ),
                          onPressed: () {
                            _searchController.clear();
                            widget.onSearch('');
                          },
                          constraints: const BoxConstraints(
                            minWidth: 30,
                            minHeight: 30,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Voice icon container
            Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD2D2D2),
                  width: 0.5,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/svgs/mic_icon.svg',
                  width: 12,
                  height: 14,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF695CFF),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            // Add New Item button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddItemScreen(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFFE8E8E8),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Add New Item',
                      style: const TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF695CFF),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.add,
                      size: 14,
                      color: Color(0xFF695CFF),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
