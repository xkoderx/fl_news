import 'package:flutter/material.dart';
import 'package:news/models/category_model.dart';
import 'package:news/services/news_service.dart';
import 'package:news/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class TabTw extends StatelessWidget {
  const TabTw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          _ListaCategorias(),
          !newsService.isLoading
              ?
          Expanded(
                  child:
                      ListaNoticias(noticias: newsService.getArticulosByCatSelc),
                )
              :
          const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
        ],
      ),
    ));
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    final Size queryData = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: queryData.height * 0.11,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (_, i) {
            final String cNome = categories[i].name;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 60,
                child: Column(
                  children: [
                    _CategoryButton(categories: categories[i]),
                    const SizedBox(height: 5),
                    Text(
                      '${cNome[0].toUpperCase()}${cNome.substring(1)}',
                      // categories[i].name,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
                        fontWeight: FontWeight.w100,
                      ),
                      textAlign: TextAlign.start,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    required this.categories,
  });

  final Category categories;

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCat = categories.name;
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categories.icon,
          color: (newsService.selectedCat == categories.name)
              ? Colors.red
              : Colors.black54,
        ),
      ),
    );
  }
}
