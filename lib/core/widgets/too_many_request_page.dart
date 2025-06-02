import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TooManyRequestsPage extends StatefulWidget {
  const TooManyRequestsPage({super.key});

  @override
  State<TooManyRequestsPage> createState() => _TooManyRequestsPageState();
}

class _TooManyRequestsPageState extends State<TooManyRequestsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _countdownSeconds = 7; // Cooldown period
  bool _isCountingDown = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start countdown timer
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_countdownSeconds > 0 && mounted) {
        setState(() {
          _countdownSeconds--;
        });
        _startCountdown();
      } else if (mounted) {
        setState(() {
          _isCountingDown = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _countdownSeconds == 0,
      child: Scaffold(
        backgroundColor: MyColor.seasalt,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main content
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated hourglass icon
                        FadeTransition(
                          opacity: _animation,
                          child: ScaleTransition(
                            scale: _animation,
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: MyColor.kellyGreen3.withAlpha(40),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: Icon(
                                Icons.hourglass_top_rounded,
                                size: 72,
                                color: MyColor.kellyGreen3,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Title text
                        Text(S.of(context).too_many_requests2,
                            textAlign: TextAlign.center,
                            style: FontHelper.fontText(
                              size: 24.sp,
                              weight: FontWeight.w700,
                              color: MyColor.kellyGreen3,
                              context: context,
                            )),
                        const SizedBox(height: 16),

                        // Description text
                        Text(
                          S.of(context).you_are_sending_too_many_requests,
                          textAlign: TextAlign.center,
                          style: FontHelper.fontText(
                            size: 16.sp,
                            weight: FontWeight.w500,
                            color: MyColor.gray,
                            context: context,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Countdown timer or retry button
                        if (_isCountingDown) ...[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  color: MyColor.kellyGreen3,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "Please wait $_countdownSeconds seconds",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColor.kellyGreen3,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: Text(S.of(context).back,
                                style: FontHelper.fontText(
                                  size: 16.sp,
                                  weight: FontWeight.w700,
                                  color: Colors.white,
                                  context: context,
                                )),
                          ),
                        ],

                        const SizedBox(height: 16),

                        // Support link
                        TextButton.icon(
                          onPressed: () {
                            // Handle navigation to support or help center
                          },
                          icon: const Icon(
                            Icons.help_outline,
                            size: 18,
                          ),
                          label: Text(S.of(context).need_help),
                          style: TextButton.styleFrom(
                            foregroundColor: MyColor.kellyGreen2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
