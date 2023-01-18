// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  var quantidade = 0.0;
  final TextEditingController _textKey = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  payMoeda() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Salvou'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${widget.moeda.price}',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 70,
              child: Text('$quantidade ${widget.moeda.symbol}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _textKey,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        quantidade = double.parse(value) / widget.moeda.price;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    labelText: 'Valor',
                    border: const OutlineInputBorder(),
                    suffix: const SizedBox(
                      width: 42,
                      child: Text(
                        'Reais',
                      ),
                    ),
                    prefixStyle:
                        TextStyle(fontSize: 14, color: Colors.grey[500]),
                    prefixIcon: const Icon(Icons.monetization_on_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe um valor';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 24, right: 16, left: 16),
              child: ElevatedButton(
                  onPressed: () {
                    payMoeda();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check),
                      SizedBox(width: 16),
                      Text(
                        'Pay',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
