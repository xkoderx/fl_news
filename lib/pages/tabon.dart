import 'package:flutter/material.dart';
import 'package:news/services/news_service.dart';
import 'package:news/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class TabOn extends StatefulWidget {
  const TabOn({Key? key}) : super(key: key);

  @override
  State<TabOn> createState() => _TabOnState();
}

class _TabOnState extends State<TabOn> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final headlines = Provider.of<NewsService>(context).headlines;
    return Scaffold(
        // body: ListaNoticias(noticias: headlines),
        body: (headlines.isEmpty)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListaNoticias(noticias: headlines));
  }
  
  @override
  bool get wantKeepAlive => true;
}
