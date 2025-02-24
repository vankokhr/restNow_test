import 'package:flutter/material.dart';
import 'package:restnow_test/services/shared_pref_service.dart';

import '../services/api_service.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  bool _isLoading = false;
  String _statusMessage = '';
  int _massageIntensity = 1;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    int intensity = await SharedPrefService.getMassageIntensity();
    setState(() {
      _massageIntensity = intensity;
    });
  }

  Future<void> _saveSettings() async {
    await SharedPrefService.setMassageIntensity(_massageIntensity);
  }

  Future<void> _sendCommand(String command) async {
    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    String response = await ApiService.sendCommand(command);
    setState(() {
      _statusMessage = response;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Massage Control')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading) CircularProgressIndicator(),
            if (_statusMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_statusMessage,
                    style: TextStyle(fontSize: 16, color: Colors.black)),
              ),
            ElevatedButton(
              onPressed: () => _sendCommand('start'),
              child: Text('Старт масажу'),
            ),
            ElevatedButton(
              onPressed: () => _sendCommand('stop'),
              child: Text('Стоп масажу'),
            ),
            Slider(
              value: _massageIntensity.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: 'Інтенсивність: $_massageIntensity',
              onChanged: (value) {
                setState(() {
                  _massageIntensity = value.toInt();
                });
                _saveSettings();
              },
            ),
          ],
        ),
      ),
    );
  }
}
