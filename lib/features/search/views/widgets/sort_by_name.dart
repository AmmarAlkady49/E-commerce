import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SortByName extends StatefulWidget {
  const SortByName({super.key});

  @override
  State<SortByName> createState() => _SortByNameState();
}

class _SortByNameState extends State<SortByName>
    with SingleTickerProviderStateMixin {
  String _selectedSortOption = 'asc_price';

  // Sorting options
  List<String> sortOptions = [
    'asc_price',
    'desc_price',
    'asc_rating',
  ];

  // Handle sorting action based on selected option
  void _onSortOptionChanged(String? newValue) {
    setState(() {
      _selectedSortOption = newValue!;
    });

    // // Handle sorting logic based on the option selected
    // if (_selectedSortOption == 'asc_price') {
    //   context.read<HomeCubit>().setSortBy(sortBy: 'asc_price');
    // } else if (_selectedSortOption == 'desc_price') {
    //   context.read<HomeCubit>().setSortBy(sortBy: 'desc_price');
    // } else if (_selectedSortOption == 'asc_rating') {
    //   context.read<HomeCubit>().setSortBy(sortBy: 'asc_rating');
    // }
  }

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              S.of(context).sort_by,
              style: FontHelper.fontText(
                context: context,
                size: 18.sp,
                weight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            Column(
              children: sortOptions.map((option) {
                String displayText;
                if (option == 'asc_price') {
                  displayText = S.of(context).sort_price_low_to_high;
                } else if (option == 'desc_price') {
                  displayText = S.of(context).sort_price_high_to_low;
                } else {
                  displayText = S.of(context).sort_by_rating;
                }

                return RadioListTile<String>(
                  value: option,
                  groupValue: _selectedSortOption,
                  activeColor: Color(0xff1D61E7),
                  onChanged: _onSortOptionChanged,
                  title: Text(
                    displayText,
                    style: FontHelper.fontText(
                      context: context,
                      size: option == _selectedSortOption ? 15.sp : 14.sp,
                      weight: option == _selectedSortOption
                          ? FontWeight.w700
                          : FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Apply Button
            MyButton1(
                width: double.infinity,
                height: 50,
                buttonTitle: S.of(context).apply,
                onTap: () {
                  // Handle apply action
                  context
                      .read<HomeCubit>()
                      .setSortBy(sortBy: _selectedSortOption);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
