// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:moedas/models/moeda_model.dart';

class MoedaDetailPage extends StatefulWidget {
  const MoedaDetailPage({
    Key? key,
    required this.moeda,
  }) : super(key: key);
  final MoedaModel moeda;
  @override
  State<MoedaDetailPage> createState() => _MoedaDetailPageState();
}

class _MoedaDetailPageState extends State<MoedaDetailPage> {
  var quantidade = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
            child: Text('$quantidade ${widget.moeda.symbol}'),
          ),
          Form(
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(),
                prefix: Text('Reais'),
                suffixIcon: Icon(Icons.monetization_on_outlined),
              ),
            ),
          )
        ],
      ),
    );
  }
}
