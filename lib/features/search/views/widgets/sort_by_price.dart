import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class SortByPrice extends StatefulWidget {
  const SortByPrice({super.key});

  @override
  State<SortByPrice> createState() => _SortByPriceState();
}

class _SortByPriceState extends State<SortByPrice>
    with SingleTickerProviderStateMixin {
  RangeValues _currentRangeValues = const RangeValues(10, 5000);
  late AnimationController _controller;
  late Animation<double> _animation;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  void _updateSliderFromFields() {
    double? min = double.tryParse(_minPriceController.text);
    double? max = double.tryParse(_maxPriceController.text);

    if (min != null && max != null && min <= max) {
      setState(() {
        _currentRangeValues = RangeValues(min, max);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _minPriceController.text = _currentRangeValues.start.round().toString();
    _maxPriceController.text = _currentRangeValues.end.round().toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return FadeTransition(
      opacity: _animation,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
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
              S.of(context).filter_by_price,
              style: FontHelper.fontText(
                  context: context,
                  size: 18.sp,
                  weight: FontWeight.w700,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            FlutterSlider(
              values: [_currentRangeValues.start, _currentRangeValues.end],
              rangeSlider: true,
              rtl: true,
              tooltip: FlutterSliderTooltip(disabled: true),
              max: 5000,
              min: 10,
              step: const FlutterSliderStep(step: 50),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                setState(() {
                  _currentRangeValues = RangeValues(lowerValue, upperValue);
                  _minPriceController.text = lowerValue.round().toString();
                  _maxPriceController.text = upperValue.round().toString();
                });
              },
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _minPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: S.of(context).min_price,
                        labelStyle: FontHelper.fontText(
                            context: context,
                            size: 16.sp,
                            weight: FontWeight.w400,
                            color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        errorStyle: FontHelper.fontText(
                            context: context,
                            size: 12.sp,
                            weight: FontWeight.w400,
                            color: Colors.red),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).empty_cell;
                        }
                        final double? parsedValue = double.tryParse(value);
                        if (parsedValue == null || parsedValue < 10) {
                          return S.of(context).please_enter_a_valid_value;
                        }
                        if (parsedValue > 5000) {
                          return S.of(context).max_must_be_greater_than_min;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final double? parsedValue = double.tryParse(value);

                        if (parsedValue != null &&
                            parsedValue <= 5000 &&
                            parsedValue >= 10) {
                          _updateSliderFromFields();
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: TextFormField(
                      controller: _maxPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: S.of(context).max_price,
                        labelStyle: FontHelper.fontText(
                            context: context,
                            size: 16.sp,
                            weight: FontWeight.w400,
                            color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        errorStyle: FontHelper.fontText(
                            context: context,
                            size: 12.sp,
                            weight: FontWeight.w400,
                            color: Colors.red),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).empty_cell;
                        }
                        final double? parsedValue = double.tryParse(value);
                        if (parsedValue == null || parsedValue > 5000) {
                          return S.of(context).please_enter_a_valid_value;
                        }
                        if (double.tryParse(_minPriceController.text) != null &&
                            parsedValue <
                                double.parse(_minPriceController.text)) {
                          return S.of(context).max_must_be_greater_than_min;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final double? parsedValue = double.tryParse(value);

                        if (parsedValue != null &&
                            parsedValue <= 5000 &&
                            parsedValue >= 10) {
                          _updateSliderFromFields();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            MyButton1(
              width: double.infinity,
              height: 50,
              buttonTitle: S.of(context).apply_filters,
              onTap: () {
                homeCubit.setMinMaxPrice(
                  double.parse(_minPriceController.text),
                  double.parse(_maxPriceController.text),
                );
                if (_formKey.currentState!.validate()) {
                  if (mounted) {
                    Navigator.pop(context);
                  }

                  // Apply your filter logic here
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
