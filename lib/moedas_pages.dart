import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moedas/models/moeda_model.dart';
import 'package:moedas/pages/moeda_detail.dart';
import 'package:moedas/repositories/moeda_repository.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  List<MoedaModel> moedasSelecionadas = [];

  appBarDynamic() {
    return moedasSelecionadas.isEmpty
        ? const SliverAppBar(
            floating: true,
            snap: true,
            title: Text('Cripto Moedas'),
          )
        : SliverAppBar(
            floating: true,
            snap: true,
            leading: IconButton(
              onPressed: () {
                setState(() {
                  moedasSelecionadas = [];
                });
              },
              icon: const Icon(Icons.refresh),
            ),
            title: Text('${moedasSelecionadas.length} selecionadas.'),
            backgroundColor: Colors.indigo[400],
          );
  }

  moedaDetail(MoedaModel moeda) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MoedaDetailPage(moeda: moeda),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var tabela = MoedaRepository.tabela;
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [appBarDynamic()],
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            return ListTile(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              selected: moedasSelecionadas.contains(tabela[index]),
              selectedTileColor: Colors.indigo[50],
              onLongPress: () {
                if (!moedasSelecionadas.contains(tabela[index])) {
                  moedasSelecionadas.add(tabela[index]);
                } else {
                  moedasSelecionadas.remove(tabela[index]);
                }
                setState(() {});
              },
              leading: moedasSelecionadas.contains(tabela[index])
                  ? const CircleAvatar(
                      child: Icon(Icons.check),
                    )
                  : SizedBox(
                      width: 40,
                      child: Image.asset(tabela[index].icon),
                    ),
              trailing: Text(real.format(tabela[index].price)),
              title: Text(
                tabela[index].name,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(tabela[index].symbol),
              onTap: () {
                moedaDetail(tabela[index]);
              },
            );
          },
          separatorBuilder: (_, __) => const Divider(),
          itemCount: tabela.length,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Favoritar'),
        icon: const Icon(Icons.star),
      ),
    );
  }
}
