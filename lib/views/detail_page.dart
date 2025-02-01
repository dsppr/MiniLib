import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/buku.dart';
import '../viewmodels/books_viewmodel.dart';
import 'add_edit_page.dart';
import 'reading_page.dart';

class DetailPage extends StatelessWidget {
  final Buku buku;

  const DetailPage({super.key, required this.buku});

  @override
  Widget build(BuildContext context) {
    final bukuViewModel = Provider.of<BukuViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(buku.judul),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditPage(buku: buku),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                    value: Provider.of<BukuViewModel>(context, listen: false),
                    child:
                        AddEditPage(buku: buku), // Kirim buku ke halaman edit
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Penulis: ${buku.penulis}',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text('Kategori: ${buku.kategori}',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text('Status: ${buku.status}',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text('Isi Buku:', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 4),
            Text(buku.isiBuku),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadingPage(buku: buku),
                  ),
                );
              },
              child: const Text('Baca Buku'),
            ),
          ],
        ),
      ),
    );
  }
}
