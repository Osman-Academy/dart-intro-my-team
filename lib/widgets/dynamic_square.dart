import 'package:flutter/material.dart';

class DynamicIcon extends StatefulWidget {
  final double initialSize;
  const DynamicIcon({super.key, required this.initialSize});

  @override
  State<DynamicIcon> createState() => _DisplaySettingsState();
}

class _DisplaySettingsState extends State<DynamicIcon> {
  late double _iconSize;
  final double _minSize = 80.0;
  final double _maxSize = 180.0;

  @override
  void initState() {
    super.initState();
    _iconSize = widget.initialSize;
  }

  void _saveSettings() {
    Navigator.pop(context, _iconSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Display Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 250,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _iconSize,
                    height: _iconSize,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage('https://via.placeholder.com/150'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: _iconSize,
                    child: Text(
                      'Product Name',
                      style: TextStyle(
                        fontSize: _calculateFontSize(_iconSize),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '\$99.99',
                    style: TextStyle(
                      fontSize: _calculateFontSize(_iconSize) - 2,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            Text(
              'Product Display Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            
            SizedBox(height: 10),
            
            Text(
              '${_iconSize.toInt()}px',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            
            SizedBox(height: 30),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSizePreset(100, 'Small'),
                _buildSizePreset(140, 'Medium'),
                _buildSizePreset(180, 'Large'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  double _calculateFontSize(double cardWidth) {
    return cardWidth * 0.09;
  }
  
  Widget _buildSizePreset(double size, String label) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {
            setState(() {
              _iconSize = size;
            });
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: _iconSize == size ? Colors.blue : null,
            foregroundColor: _iconSize == size ? Colors.white : Colors.blue,
          ),
          child: Text(label),
        ),
      ],
    );
  }
}