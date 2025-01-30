import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/buku.dart';

class FirebaseService {
  final CollectionReference _booksCollection =
      FirebaseFirestore.instance.collection('books');

  Future<void> addBook(Buku buku) async {
    await _booksCollection.add(buku.toMap());
  }

  Stream<List<Buku>> getBooks() {
    return _booksCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Buku.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  Future<void> updateBook(Buku buku) async {
    await _booksCollection.doc(buku.id).update(buku.toMap());
  }

  Future<void> deleteBook(String id) async {
    await _booksCollection.doc(id).delete();
  }

  Future<void> addInitialBooks() async {
    List<Buku> initialBooks = [
      Buku(
        id: '',
        judul: 'Fur Immer Dein Ian',
        penulis: 'Valerie',
        kategori: 'Romance',
        status: 'Available',
        isiBuku:
            'Apakah ada yang lebih menyebalkan daripada menyembunyikan perasaan atas nama pertemanan?...',
        gambarSampul: 'assets/images/fur_immer_dein_ian.jpg',
      ),
      Buku(
        id: '',
        judul: 'Majnun',
        penulis: 'Anton Kurnia',
        kategori: 'Historical Fiction',
        status: 'Available',
        isiBuku:
            'Majnun adalah kisah cinta, persahabatan, dan catatan atas sejarah yang dilupakan...',
        gambarSampul: 'assets/images/majnun_anton_kurnia.jpg',
      ),
      // Tambahkan buku lainnya sesuai kebutuhan
    ];

    for (var buku in initialBooks) {
      await addBook(buku);
    }
  }
}
