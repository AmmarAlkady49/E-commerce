import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/search/cubit/search_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class SpeechToTextSearchPage extends StatefulWidget {
  const SpeechToTextSearchPage({super.key});

  @override
  State<SpeechToTextSearchPage> createState() => _SpeechToTextSearchPageState();
}

class _SpeechToTextSearchPageState extends State<SpeechToTextSearchPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchCubit = BlocProvider.of<SearchCubit>(context);

    return Scaffold(
      backgroundColor: MyColor.seasalt,
      appBar: AppBarDefaultTheme(
        title: S.of(context).search_by_voice,
      ),
      body: BlocConsumer<SearchCubit, SearchState>(
        bloc: searchCubit,
        listenWhen: (previous, current) =>
            current is SearchInitializationFailed ||
            current is SpeechToTextError,
        listener: (context, state) {
          // Show snackbar for initialization failures
          if (state is SearchInitializationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error,
                textAlign: TextAlign.start,
                style: FontHelper.fontText(
                    size: 15.sp,
                    weight: FontWeight.w600,
                    color: Colors.white,
                    context: context),
              ),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ));
          }
        },
        buildWhen: (previous, current) =>
            !(current is SearchInitial || current is SearchInitializing) ||
            current is SearchInitialized,
        builder: (context, state) {
          // Handle initial loading state
          if (state is SearchInitializing) {
            return const Center(child: CupertinoActivityIndicator());
          }

          final bool hasSpokenText =
              state is SpeechToTextLoaded && state.text.trim().isNotEmpty;

          final String displayText = state is SpeechToTextLoaded
              ? state.text
              : S.of(context).start_speaking;

          final String? errorMessage = state is SpeechToTextError
              ? state.error
              : (state is SearchInitializationFailed ? state.error : null);

          return FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  // Top spacing
                  SizedBox(height: 20.h),

                  // Voice visualization or hint animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: 120.h,
                    width: double.infinity,
                    child: searchCubit.isListening
                        ? _buildWaveformAnimation()
                        : _buildMicrophoneHintAnimation(),
                  ),

                  SizedBox(height: 30.h),

                  // Text display area with animation
                  _buildTextDisplayArea(displayText, context),

                  // Error message if needed
                  if (errorMessage != null) _buildErrorMessage(errorMessage),

                  const Spacer(),

                  // Control buttons at bottom
                  _buildControlButtons(context, searchCubit, hasSpokenText),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWaveformAnimation() {
    return Container(
      decoration: BoxDecoration(
        color: MyColor.kellyGreen3.withAlpha(50),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => _buildPulsingBar(index),
          ),
        ),
      ),
    );
  }

  Widget _buildPulsingBar(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.3, end: 1.0),
        duration: Duration(milliseconds: 600 + (index * 100)),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Transform.scale(
            scaleY: value,
            child: Container(
              width: 12.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: MyColor.kellyGreen3.withAlpha(250),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMicrophoneHintAnimation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Icon(
          Iconsax.microphone_25,
          size: 48.sp,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildTextDisplayArea(String displayText, BuildContext context) {
    final bool isEmptyPrompt = displayText == S.of(context).start_speaking;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: BoxConstraints(
        minHeight: 100.h,
        maxHeight: 200.h,
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isEmptyPrompt)
            Icon(
              Icons.mic_none_outlined,
              size: 28.sp,
              color: Colors.grey.shade400,
            ),
          SizedBox(height: 8.h),
          Text(
            displayText,
            textAlign: TextAlign.center,
            style: FontHelper.fontText(
              size: isEmptyPrompt ? 16.sp : 18.sp,
              weight: FontWeight.w600,
              context: context,
              color: isEmptyPrompt ? Colors.grey.shade500 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String error) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: Colors.red.shade700,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                error,
                style: TextStyle(
                  color: Colors.red.shade800,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButtons(
      BuildContext context, SearchCubit searchCubit, bool hasSpokenText) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Cancel Button
          _buildRoundButton(
            onTap: () => Navigator.of(context).pop(),
            size: 56.w,
            backgroundColor: Colors.red.shade100,
            iconColor: Colors.red.shade700,
            icon: Icons.close_rounded,
          ),

          SizedBox(width: 20.w),

          // Microphone Button
          AvatarGlow(
            animate: searchCubit.isListening,
            glowColor: MyColor.kellyGreen3,
            duration: const Duration(milliseconds: 1500),
            child: _buildRoundButton(
              onTap: () {
                searchCubit.isNotListening
                    ? searchCubit.startListening()
                    : searchCubit.stopListening();
              },
              size: 70.w,
              backgroundColor: searchCubit.isListening
                  ? Colors.red.shade400
                  : MyColor.kellyGreen3,
              iconColor: Colors.white,
              icon: searchCubit.isNotListening
                  ? Iconsax.microphone_25
                  : Icons.stop_rounded,
            ),
          ),

          SizedBox(width: 20.w),

          // Submit Button
          _buildRoundButton(
            onTap: hasSpokenText
                ? () {
                    final trimmedText = searchCubit.spokenText.trim();
                    if (trimmedText.isNotEmpty) {
                      log("Submitted: $trimmedText");
                      Navigator.pop(context, trimmedText);
                    }
                  }
                : null,
            size: 56.w,
            backgroundColor:
                hasSpokenText ? Colors.blue.shade500 : Colors.grey.shade300,
            iconColor: hasSpokenText ? Colors.white : Colors.grey.shade500,
            icon: CupertinoIcons.checkmark_alt,
          ),
        ],
      ),
    );
  }

  Widget _buildRoundButton({
    required VoidCallback? onTap,
    required double size,
    required Color backgroundColor,
    required Color iconColor,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: size * 0.45,
          color: iconColor,
        ),
      ),
    );
  }
}
