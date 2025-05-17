import 'package:flutter/material.dart';
import 'models/result_cep.dart';
import 'services/via_cep_service.dart';

void main() {
  runApp(ConsultaCepApp());
}

class ConsultaCepApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta de CEP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConsultaCepPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ConsultaCepPage extends StatefulWidget {
  @override
  _ConsultaCepPageState createState() => _ConsultaCepPageState();
}

class _ConsultaCepPageState extends State<ConsultaCepPage> {
  final TextEditingController _cepController = TextEditingController();
  final ViaCepService _viaCepService = ViaCepService();
  String _resultado = '';

  void _buscarCep() async {
    final cep = _cepController.text.trim();

    if (cep.isEmpty) {
      setState(() {
        _resultado = 'Por favor, informe um CEP válido.';
      });
      return;
    }

    final result = await _viaCepService.buscarCep(cep);

    if (result != null) {
      setState(() {
        _resultado =
            '${result.logradouro}, ${result.bairro}, ${result.localidade} - ${result.uf}';
      });
    } else {
      setState(() {
        _resultado = 'CEP não encontrado ou inválido.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta de CEP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cepController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'CEP',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _buscarCep,
        child: Icon(Icons.search),
      ),
    );
  }
}
