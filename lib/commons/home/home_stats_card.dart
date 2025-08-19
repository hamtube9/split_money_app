// A reusable widget for the home stats card.
// It is a StatelessWidget because it doesn't manage its own state.
import 'package:flutter/material.dart';
import 'package:split_money/extension/context.dart';

class HomeStatsCard extends StatelessWidget {
  final String title;
  final double value;
  final bool isOwe;


  const HomeStatsCard({
    super.key,
    required this.title,
    required this.value, required this.isOwe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Fixed width for a card-like appearance
      height: 120, // Fixed height
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff474747), Color(0xff0d0d0c)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5), // Adds a subtle shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The monetary value text
                Text(
                  "\$${value.toStringAsFixed(2)}",
                  style: context.headerTextWhite().copyWith(fontSize: 28),
                ),
                const SizedBox(height: 4),
                // The descriptive title text
                Expanded(
                  child: Text(
                    title,
                    style: context.normalTextWhite().copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 16,
                    ),
                  ),
                ),

                // The icon at the bottom right
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Transform.rotate(
                angle: isOwe? -45.0 : 90,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
