import 'package:flutter/material.dart';
import '../models/buku.dart';
import '../services/firebase_service.dart';

class BukuViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Buku> _bukuList = [];
  bool _isLoading = false;

  List<Buku> get bukuList => _bukuList;
  bool get isLoading => _isLoading;

  BukuViewModel() {
    fetchBuku();
  }

  // **1️⃣ Ambil Data Buku dari Firestore**
  void fetchBuku() {
    _isLoading = true;
    notifyListeners();

    _firebaseService.getBooks().listen((bukuData) {
      _bukuList = bukuData;
      _isLoading = false;
      notifyListeners();
    });
  }

  // **2️⃣ Tambah Buku Baru**
  Future<void> tambahBuku(Buku buku) async {
    try {
      await _firebaseService.addBook(buku);
    } catch (e) {
      debugPrint('Gagal menambahkan buku: $e');
    }
  }

  // **3️⃣ Edit Buku**
  Future<void> editBuku(Buku buku) async {
    try {
      await _firebaseService.updateBook(buku);
    } catch (e) {
      debugPrint('Gagal memperbarui buku: $e');
    }
  }

  // **4️⃣ Hapus Buku**
  Future<void> hapusBuku(String id) async {
    try {
      await _firebaseService.deleteBook(id);
    } catch (e) {
      debugPrint('Gagal menghapus buku: $e');
    }
  }
}
