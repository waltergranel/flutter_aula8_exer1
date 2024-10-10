import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Calculadora(),
      ),
    ),
  );
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final TextEditingController _controlaX = TextEditingController();
  final TextEditingController _controlaY = TextEditingController();
  int resultado = 0;
  late int _x;
  late int _y;

  @override
  void initState() {
    super.initState();
    carrega();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 80,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                controller: _controlaX,
                decoration: const InputDecoration(labelText: 'Valor do X'),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextField(
                controller: _controlaY,
                decoration: const InputDecoration(labelText: 'Valor do Y'),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: soma,
          child: const Text('Soma'),
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          'Resultado: $resultado',
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: salva, child: const Text('Salva')),
            ElevatedButton(onPressed: limpa, child: const Text('Limpa')),
          ],
        ),
      ],
    );
  }

  void soma() {
    _x = int.parse(_controlaX.text);
    _y = int.parse(_controlaY.text);

    setState(() {
      resultado = _x + _y;
    });
  }

  void salva() async {
    // Load and obtain the shared preferences for this app.
    final prefs = await SharedPreferences.getInstance();

// Save the counter value to persistent storage under the 'counter' key.
    await prefs.setInt('_X', _x);
    await prefs.setInt('_Y', _y);
  }

  void limpa() async {
    final prefs = await SharedPreferences.getInstance();

// Remove the counter key-value pair from persistent storage.
    await prefs.remove('_X');
    await prefs.remove('_Y');
    _controlaX.text = '';
    _controlaY.text = '';
  }

  void carrega() async {
    final prefs = await SharedPreferences.getInstance();

// Try reading the counter value from persistent storage.
// If not present, null is returned, so default to 0.
    _x = prefs.getInt('_X') ?? 0;
    _y = prefs.getInt('_Y') ?? 0;
    _controlaX.text = '$_x';
    _controlaY.text = '$_y';
  }
}
