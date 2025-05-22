import 'package:flutter/material.dart';
import 'models/resultado_cep.dart';
import 'services/servico_via_cep.dart';

void main() {
  runApp(AppConsultaCep());
}

class AppConsultaCep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta de CEP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: PaginaConsultaCep(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PaginaConsultaCep extends StatefulWidget {
  @override
  _EstadoPaginaConsultaCep createState() => _EstadoPaginaConsultaCep();
}

class _EstadoPaginaConsultaCep extends State<PaginaConsultaCep> {
  final TextEditingController _controladorCep = TextEditingController();
  final ServicoViaCep _servicoViaCep = ServicoViaCep();
  ResultadoCep? _resultadoCep;
  String _mensagemErro = '';

  void _consultarCep() async {
    setState(() {
      _mensagemErro = '';
      _resultadoCep = null;
    });

    final cep = _controladorCep.text.trim();

    if (cep.isEmpty) {
      setState(() {
        _mensagemErro = 'Informe um CEP válido.';
      });
      return;
    }

    final resultado = await _servicoViaCep.buscarCep(cep);

    if (resultado != null) {
      setState(() {
        _resultadoCep = resultado;
      });
    } else {
      setState(() {
        _mensagemErro = 'CEP não encontrado ou inválido.';
      });
    }
  }

  Widget _buildResultado() {
    if (_resultadoCep != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          Text('Logradouro: ${_resultadoCep!.logradouro}'),
          Text('Bairro: ${_resultadoCep!.bairro}'),
          Text('Cidade: ${_resultadoCep!.localidade}'),
          Text('Estado: ${_resultadoCep!.uf}'),
        ],
      );
    } else if (_mensagemErro.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          _mensagemErro,
          style: TextStyle(color: Colors.red),
        ),
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Consulta de CEP',
        style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
        
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, size: 50, color: Colors.blue),
                SizedBox(height: 10),
                Text(
                  'Digite um CEP para consultar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _controladorCep,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'CEP',
                    labelStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.check,
                  color:Colors.white),
                  label: Text('Consultar',
                  style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: _consultarCep,
                ),
                SizedBox(height: 20),
                _buildResultado(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
