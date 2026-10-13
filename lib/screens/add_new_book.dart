import 'package:book_management_app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/book_model.dart';
import '../theme/app_colors.dart';
import '../widgets/auth_textfield.dart';
import '../widgets/back_button.dart';
import '../widgets/primary_button.dart';

class AddBookScreen extends StatefulWidget {
  final BookModel? book;
  AddBookScreen({super.key, this.book});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final coverController = TextEditingController();
  final nameController = TextEditingController();
  final authorController = TextEditingController();
  final priceController = TextEditingController();
  String coverUrl = '';
  bool _isLoading = false;

  bool get isEditing => widget.book != null;

  @override
  void initState() {
    super.initState();
    final book = widget.book;
    if (book != null) {
      nameController.text = book.title;
      authorController.text = book.author;
      priceController.text = book.price.toString();
      coverController.text = book.coverUrl;
      coverUrl = book.coverUrl;
    }
  }

  @override
  void dispose() {
    coverController.dispose();
    nameController.dispose();
    authorController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ─── Header ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    BackButtonWidget(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isEditing ? 'Edit Book' : 'Add New Book',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(
                            isEditing
                                ? 'Update your book details'
                                : 'Fill in the details below',
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ─── Scrollable content ───────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Book cover preview
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 180,
                              decoration: BoxDecoration(
                                color: AppColors.card,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.cardBorder,
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.primary.withOpacity(0.12),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: coverUrl.isNotEmpty
                                  ? Image.network(
                                      coverUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          _coverPlaceholder(),
                                      loadingBuilder: (
                                        context,
                                        child,
                                        progress,
                                      ) {
                                        if (progress == null) return child;
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primary,
                                            strokeWidth: 2,
                                          ),
                                        );
                                      },
                                    )
                                  : _coverPlaceholder(),
                            ),
                            // Badge
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.link_rounded,
                                  color: Color(0xFF1A1730),
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      AuthTextField(
                        controller: coverController,
                        label: 'COVER IMAGE URL',
                        hint: 'Paste image URL here',
                        prefixIcon: Icons.link_rounded,
                        onChanged: (val) {
                          setState(() => coverUrl = val.trim());
                        },
                      ),

                      const SizedBox(height: 18),

                      AuthTextField(
                        controller: nameController,
                        label: 'BOOK TITLE',
                        hint: 'Enter book title',
                        prefixIcon: Icons.book_outlined,
                      ),

                      const SizedBox(height: 18),

                      AuthTextField(
                        controller: authorController,
                        label: 'AUTHOR',
                        hint: 'Enter author name',
                        prefixIcon: Icons.person_outline_rounded,
                      ),

                      const SizedBox(height: 18),

                      AuthTextField(
                        controller: priceController,
                        label: 'PRICE',
                        hint: 'e.g. 12.99',
                        prefixIcon: Icons.attach_money_rounded,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),

                      const SizedBox(height: 32),

                      PrimaryButton(
                        text: isEditing ? 'Update Book' : 'Add to Library',
                        isLoading: _isLoading,
                        icon: isEditing
                            ? Icons.check_rounded
                            : Icons.add_rounded,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _coverPlaceholder() {
    return Container(
      color: AppColors.surface,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_rounded,
            color: AppColors.primary.withOpacity(0.5),
            size: 40,
          ),
          const SizedBox(height: 10),
          const Text(
            'Book Cover',
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final cover = coverController.text.trim();
    final name = nameController.text.trim();
    final author = authorController.text.trim();
    final price = priceController.text.trim();

    if (cover.isEmpty) {
      _showSnack('Please enter a cover image URL', isError: true);
      return;
    }
    if (name.isEmpty) {
      _showSnack('Please enter a book title', isError: true);
      return;
    }
    if (author.isEmpty) {
      _showSnack('Please enter an author name', isError: true);
      return;
    }
    if (price.isEmpty) {
      _showSnack('Please enter a price', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    final bookData = {
      'bookimage': cover,
      'bookName': name,
      'bookAuther': author,
      'bookprice': price,
    };

    try {
      if (!isEditing) {
        await FirebaseFirestore.instance.collection('books').add(bookData);
        if (mounted) _showSnack('Book added to library!');
      } else {
        await FirebaseFirestore.instance
            .collection('books')
            .doc(widget.book!.id)
            .update(bookData);
        if (mounted) _showSnack('Book updated successfully!');
      }
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnack('Something went wrong. Try again.', isError: true);
      }
    }
  }

  void _showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
