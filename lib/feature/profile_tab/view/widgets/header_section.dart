import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:movies_app/core/utilities/app_padding.dart';

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Row(
        //  mainAxisAlignment: .spaceBetween,
        children: [
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                Expanded(
                  flex: 10,
                  child: FittedBox(
                    child: Image.asset(
                      'assets/images/png/gamer(1).png',
                      height: 118,
                      width: 118,
                      fit: .fill,
                    ),
                  ),
                ),
                const Gap(16),
                const Expanded(
                  flex: 3,
                  child: FittedBox(
                    child: Text(
                      'Ahmed elnoby',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 14,
            child: Padding(
              padding: EdgeInsets.all(26),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: .center,
                      children: [
                        Expanded(
                          flex: 16,
                          child: FittedBox(
                            child: Text(
                              '12',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: .bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: FittedBox(
                            child: Text(
                              'Watch List',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: .bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: .end,
                      children: [
                        Expanded(
                          flex: 16,
                          child: FittedBox(
                            child: Text(
                              '10',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: .bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: FittedBox(
                            child: Text(
                              'History',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: .bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
