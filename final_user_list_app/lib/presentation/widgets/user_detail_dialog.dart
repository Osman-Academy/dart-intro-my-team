// Presentation - User Detail Dialog
import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

class UserDetailDialog extends StatelessWidget {
  final User user;

  const UserDetailDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 40,
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '@${user.username}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const Divider(height: 32),
              _buildDetailSection(
                'Contact Information',
                [
                  _buildDetailRow(Icons.email, 'Email', user.email),
                  _buildDetailRow(Icons.phone, 'Phone', user.phone),
                  _buildDetailRow(Icons.language, 'Website', user.website),
                ],
              ),
              if (user.address != null) ...[
                const SizedBox(height: 16),
                _buildDetailSection(
                  'Address',
                  [
                    _buildDetailRow(Icons.location_city, 'City', user.address!.city),
                    _buildDetailRow(Icons.home, 'Street', user.address!.street),
                    _buildDetailRow(Icons.apartment, 'Suite', user.address!.suite),
                    _buildDetailRow(Icons.markunread_mailbox, 'Zipcode', user.address!.zipcode),
                  ],
                ),
              ],
              if (user.company != null) ...[
                const SizedBox(height: 16),
                _buildDetailSection(
                  'Company',
                  [
                    _buildDetailRow(Icons.business, 'Name', user.company!.name),
                    _buildDetailRow(Icons.work, 'Catch Phrase', user.company!.catchPhrase),
                    _buildDetailRow(Icons.business_center, 'BS', user.company!.bs),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
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
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
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
