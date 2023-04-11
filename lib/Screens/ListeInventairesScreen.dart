
import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Models/Inventaire.dart';

import 'package:inventaire_mobile/Screens/LoginScreen.dart';
class ArticleListScreen extends StatefulWidget {
  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  final InventaireController _articleService = InventaireController();
  List<Inventaire> _articles = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _fetchArticles();

  }
/*_deleteArticles(Article article) async {
  void result = await _articleService.deleteArticle(article.reference)
  if (result == 1) {
    setState(() {
      _articles.remove(article);
    });
  }
}*/
  _fetchArticles() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Inventaire> articles = await _articleService.fetchInventaires();
      setState(() {
        _isLoading = false;
        _articles = articles;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(
          title: Text("All Articles"),
        ),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Row(
          children: [
            Expanded(
              child: Container(
                //width: 500,
                child: ListView.builder(
                  itemCount: _articles.length,
                  itemBuilder: (context, index) {
                    Inventaire article = _articles[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListTile(
                          // leading: Text(article.reference ?? ''),
                          title: Row(
                            children: [
                              Expanded(child: Text("reference")),
                              Expanded(child: Text("libelle")),
                              Expanded(child: Text("description")),
                              Expanded(child: Text("prix")),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Expanded(child: Text(article.numinv)),
                              Expanded(child: Text(article.numinv)),
                              Expanded(child: Text(article.codedep)),

                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => login(),
            ),
          ),
        )

    );
  }
}

