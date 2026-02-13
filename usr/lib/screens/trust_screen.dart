import 'package:flutter/material.dart';

class TrustScreen extends StatelessWidget {
  const TrustScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trust & Quality')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Quality Certificates', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildCertificateCard('ISO 22000:2018 Food Safety Management', 'Certified for food safety and quality management systems'),
            _buildCertificateCard('HACCP Certification', 'Hazard Analysis and Critical Control Points compliance'),
            _buildCertificateCard('Organic Certification', 'Certified organic ice cream production'),
            const SizedBox(height: 32),
            const Text('Hygiene Standards', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildHygieneItem('Sanitation Protocols', 'Daily cleaning and sterilization of all equipment'),
            _buildHygieneItem('Employee Hygiene', 'Mandatory hand washing and protective clothing'),
            _buildHygieneItem('Facility Standards', 'Temperature-controlled clean rooms'),
            _buildHygieneItem('Raw Material Inspection', 'Quality checks on all incoming ingredients'),
            const SizedBox(height: 32),
            const Text('Customer Reviews', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildReviewCard('Sarah M.', 5, 'Amazing quality and perfect temperature maintenance!'),
            _buildReviewCard('John D.', 5, 'Fresh and delicious. Will order again.'),
            _buildReviewCard('Emma L.', 4, 'Great service and on-time delivery.'),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificateCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.verified, color: Colors.green, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHygieneItem(String title, String description) {
    return ListTile(
      leading: const Icon(Icons.clean_hands, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(description),
    );
  }

  Widget _buildReviewCard(String name, int rating, String review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                Row(
                  children: List.generate(5, (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 16,
                  )),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(review),
          ],
        ),
      ),
    );
  }
}