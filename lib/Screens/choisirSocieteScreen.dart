
import 'package:flutter/material.dart';
import 'package:inventaire_mobile/Controllers/AuthController.dart';
import 'package:inventaire_mobile/Controllers/InventaireController.dart';
import 'package:inventaire_mobile/Models/Inventaire.dart';
import 'package:inventaire_mobile/Models/UserSoc.dart';
import 'package:inventaire_mobile/Screens/ListeInventairesScreen.dart';
import 'package:inventaire_mobile/Screens/LoginScreen.dart';
class ChoisirSocieteScreen extends StatefulWidget {
  @override
  State<ChoisirSocieteScreen> createState() => _ChoisirSocieteScreen();
}

class _ChoisirSocieteScreen extends State<ChoisirSocieteScreen> {
  final InventaireController _articleService = InventaireController();
  final AuthController _authController = AuthController();
  List<UserSoc> _articles = [];
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
      List<UserSoc> articles = await _articleService.fetchUserSocs();
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
                    UserSoc article = _articles[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          String soc = article.societe; // or use your own logic to get the selected 'soc' value
                          try {
                            await _authController.choisirSociete(soc);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => ArticleListScreen()),
                            );
                          } catch (e) {
                            print(e);
                            // handle error response here
                          }
                        },
                        child: Text(article.societe),
                      ),
                    );
                  },
                )

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

