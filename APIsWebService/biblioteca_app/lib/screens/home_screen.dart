import 'package:biblioteca_app/providers/book_provider.dart';
import 'package:biblioteca_app/screens/book_form_screen.dart';
import 'package:biblioteca_app/widgets/book_container.dart';
import 'package:biblioteca_app/widgets/custom_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookProvider>(context, listen: false).fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _bookProvider.fetchBooks();
        },
        child: _bookProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Livros disponíveis",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Consumer<BookProvider>(
                    builder: (context, bookProvider, child) {
                      return SizedBox(
                        height: 325,
                        child: CarouselSlider.builder(
                          itemCount: bookProvider.availableBooks.length,
                          itemBuilder: (context, index, realIndex) {
                            final book = bookProvider.availableBooks[index];
                            return BookContainer(book: book);
                          },
                          options: CarouselOptions(
                            height: 300,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.7,
                            aspectRatio: 16 / 9,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("Lista geral: ", style: Theme.of(context).textTheme.titleMedium,),
                  ),
                  Consumer<BookProvider>(
                    builder: (context, provider, child) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: provider.books.length,
                          shrinkWrap: false,
                          itemBuilder: (context, index) {
                            final book = provider.books[index];
                            return Card(
                              child: ListTile(
                                leading: ClipRRect(borderRadius: BorderRadiusGeometry.circular(16), child: Image.network(book.imageUrl)),
                                title: Text(book.title),
                                subtitle: Text(book.author),
                                trailing: IconButton(onPressed: () {
                                  provider.deleteBook(book.id!);
                                }, icon: Icon(Icons.delete, color: Colors.red,)),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
            floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookFormScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
