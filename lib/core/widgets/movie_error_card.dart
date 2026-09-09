import 'package:flutter/material.dart';

class MovieErrorCard extends StatelessWidget {
  final String errorMessage;

  const MovieErrorCard({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 35,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
