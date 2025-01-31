import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../models/buku.dart';

class FirebaseService {
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');
  final Logger logger = Logger();

  // ✅ Tambah Buku dengan Error Handling
  Future<void> addBook(Buku buku) async {
    try {
      await booksCollection.doc().set(buku.toMap());
      logger.i("Buku berhasil ditambahkan!");
    } catch (e) {
      logger.e("Error saat menambahkan buku: $e");
    }
  }

  // ✅ Baca Buku dengan Stream
  Stream<List<Buku>> getBooks() {
    return booksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Buku.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // ✅ Edit Buku
  Future<void> updateBook(Buku buku) async {
    try {
      await booksCollection.doc(buku.id).update(buku.toMap());
      logger.i("Buku berhasil diperbarui!");
    } catch (e) {
      logger.e("Error saat memperbarui buku: $e");
    }
  }

  // ✅ Hapus Buku
  Future<void> deleteBook(String id) async {
    try {
      await booksCollection.doc(id).delete();
      logger.i("Buku berhasil dihapus!");
    } catch (e) {
      logger.e("Error saat menghapus buku: $e");
    }
  }

  // // ✅ Seed Books (Pastikan Data Tidak Duplikat)
  // Future<void> seedBooks() async {
  //   try {
  //     QuerySnapshot existingBooks = await booksCollection.get();
  //     if (existingBooks.docs.isNotEmpty) {
  //       logger.w("Database sudah memiliki data, seedBooks() dibatalkan.");
  //       return;
  //     }

  //     List<Map<String, dynamic>> booksData = [
  //       {
  //         'judul': 'Fur Immer Dein Ian',
  //         'penulis': 'Valerie',
  //         'kategori': 'Romance',
  //         'status': 'Available',
  //         'isiBuku':
  //             'Apakah ada yang lebih menyebalkan daripada menyembunyikan perasaan atas nama pertemanan?...',
  //         'gambarSampul': 'assets/images/fur_immer_dein_ian.jpg'
  //       },
  //       {
  //         'judul': 'Majnun',
  //         'penulis': 'Anton Kurnia',
  //         'kategori': 'Historical Fiction',
  //         'status': 'Available',
  //         'isiBuku':
  //             'Majnun adalah kisah cinta, persahabatan, dan catatan atas sejarah yang dilupakan...',
  //         'gambarSampul': 'assets/images/majnun_anton_kurnia.jpg'
  //       },
  //       {
  //         'judul': 'I Think I Love You',
  //         'penulis': 'Cha Mirae',
  //         'kategori': 'Young Adult Romance',
  //         'status': 'Available',
  //         'isiBuku':
  //             'Dua pria tampan di Kyunghee University, Jang Taehyun dan Han Seokjin, terlibat konflik...',
  //         'gambarSampul': 'assets/images/i_think_i_love_you_cha_mirae.jpg'
  //       }
  //     ];

  //     for (var book in booksData) {
  //       await booksCollection.add(book);
  //     }

  //     logger.i("Seed data berhasil ditambahkan.");
  //   } catch (e) {
  //     logger.e("Error saat melakukan seeding data: $e");
  //   }
  // }
}
