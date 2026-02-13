import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TemperatureScreen extends StatelessWidget {
  const TemperatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock temperature data
    final temperatureData = [
      const FlSpot(0, -18), // Factory
      const FlSpot(1, -15), // Loading
      const FlSpot(2, -12), // Transport
      const FlSpot(3, -10), // Warehouse
      const FlSpot(4, -8),  // Delivery
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Temperature Logs')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cold Chain Verified', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.verified, color: Colors.green),
                  SizedBox(width: 8),
                  Text('All temperatures maintained within safe range (-18°C to -8°C)'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Temperature History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = ['Factory', 'Loading', 'Transport', 'Warehouse', 'Delivery'];
                          return Text(titles[value.toInt()], style: const TextStyle(fontSize: 10));
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: temperatureData,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 4,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Quality Assurance Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildDetailRow('Batch ID', 'IC2024001'),
            _buildDetailRow('Production Date', '2024-01-15'),
            _buildDetailRow('Best Before', '2024-03-15'),
            _buildDetailRow('Storage Temperature', '-18°C'),
            _buildDetailRow('Transport Method', 'Refrigerated Truck'),
            _buildDetailRow('Quality Check', 'PASSED'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }
}