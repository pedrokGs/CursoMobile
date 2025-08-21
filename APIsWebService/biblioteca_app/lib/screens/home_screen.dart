import 'package:biblioteca_app/providers/book_provider.dart';
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
      appBar: CustomAppBar(title: "Library"),
      body: RefreshIndicator(
        onRefresh: () async {
          _bookProvider.fetchBooks();
        },
        child: _bookProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Minha Estante",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  ),
                  const SizedBox(height: 12),
                  Consumer<BookProvider>(
                  builder: (context, bookProvider, child) {
                    return SizedBox(
                    height: 325,
                    child: CarouselSlider.builder(
                      itemCount: bookProvider.books.length,
                      itemBuilder: (context, index, realIndex) {
                      final book = bookProvider.books[index];
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
                ],
              ),
      ),
    );
  }
}
