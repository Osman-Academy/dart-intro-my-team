import 'package:dynamic_square/interactive_square_demo.dart';
import 'package:flutter/material.dart';

class InteractiveSquareDemoState extends State<InteractiveSquareDemo> {
  double _sideLength = 150.0;
  final double _maxSideLength = 300.0;
  final double _minSideLength = 20.0;

  double get _area => _sideLength * _sideLength;
  double get _perimeter => _sideLength * 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Square Area'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.purple.shade200],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Info Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoCard(
                      'Side Length',
                      '${_sideLength.toStringAsFixed(1)} px',
                      Icons.straighten,
                      Colors.blue,
                    ),
                    _buildInfoCard(
                      'Area',
                      '${_area.toStringAsFixed(0)} px²',
                      Icons.crop_square,
                      Colors.green,
                    ),
                    _buildInfoCard(
                      'Perimeter',
                      '${_perimeter.toStringAsFixed(1)} px',
                      Icons.border_outer,
                      Colors.orange,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 60),
              
              // The Square
              Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: _sideLength,
                    height: _sideLength,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.cyan.shade400,
                          Colors.blue.shade600,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${_sideLength.toStringAsFixed(0)}×${_sideLength.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 60),
              
              // Slider Control
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_minSideLength.toInt()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Adjust Side Length',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${_maxSideLength.toInt()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: Colors.cyan,
                        inactiveTrackColor: Colors.white,
                        thumbColor: Colors.white,
                        overlayColor: Colors.cyan,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 12,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 24,
                        ),
                      ),
                      child: Slider(
                        value: _sideLength,
                        min: _minSideLength,
                        max: _maxSideLength,
                        onChanged: (value) {
                          setState(() {
                            _sideLength = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Reset Button
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _sideLength = 150.0;
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}