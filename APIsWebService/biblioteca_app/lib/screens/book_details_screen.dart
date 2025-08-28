import 'package:biblioteca_app/models/book.dart';
import 'package:biblioteca_app/providers/book_provider.dart';
import 'package:biblioteca_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BookDetailsScreen extends StatefulWidget {
  Book book;
  BookDetailsScreen({super.key, required this.book});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.book.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final _bookProvider = Provider.of<BookProvider>(context);
    Book book = widget.book;

    return Scaffold(
      appBar: CustomAppBar(title: book.title),
      body: _bookProvider.isLoading
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Column(
                        children: [
                          Hero(
                            tag: book.id!,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                book.imageUrl,
                                width: double.infinity,
                                alignment: Alignment.topCenter,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(child: Icon(Icons.error)),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  book.title,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                Text(
                                  book.author,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const SizedBox(height: 24),
                                Text(
                                  "Sinopse",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  book.summary,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        heroTag: "FavoriteFAB",
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border_outlined),
        ),
        onPressed: () async {
          setState(() {
            isFavorite = !isFavorite;
            _bookProvider.toggleFavorite(book.id!, isFavorite);
          });
        },
      ),
    );
  }
}
