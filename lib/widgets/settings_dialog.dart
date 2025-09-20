import 'package:flutter/material.dart';

import '../pages/privacy_policy_page.dart';

class AppInfoDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'About गजलगम',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Developer Info
                    _buildInfoSection(
                      context,
                      'Developed by',
                      'Gamalgorithm Technology',
                      Icons.business,
                    ),
                    const SizedBox(height: 16),

                    // Author Info
                    _buildInfoSection(
                      context,
                      'Author',
                      'Bikesh Gamal',
                      Icons.person,
                    ),
                    const SizedBox(height: 16),

                    // Privacy Policy Section
                    _buildPrivacyPolicySection(context),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static Widget _buildInfoSection(
      BuildContext context, String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildPrivacyPolicySection(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(
          Icons.privacy_tip_outlined,
          color: Theme.of(context).primaryColor,
          size: 24,
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: const Text(
          'View our privacy policy and data usage',
          style: TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.of(context).pop(); // Close the dialog first
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PrivacyPolicyPage(),
            ),
          );
        },
      ),
    );
  }
}
