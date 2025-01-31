import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final Logger logger = Logger();
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');

  try {
    QuerySnapshot existingBooks = await booksCollection.get();
    if (existingBooks.docs.isNotEmpty) {
      logger.w("📢 Database sudah memiliki data, seedBooks() dibatalkan.");
      return;
    }

    List<Map<String, dynamic>> booksData = [
      {
        'judul': 'Fur Immer Dein Ian',
        'penulis': 'Valerie',
        'kategori': 'Romance',
        'status': 'Available',
        'isi_buku':
            'Apakah ada yang lebih menyebalkan daripada menyembunyikan perasaan atas nama pertemanan?...',
        'gambar_sampul': 'assets/images/fur_immer_dein_ian.jpg'
      },
      {
        'judul': 'Majnun',
        'penulis': 'Anton Kurnia',
        'kategori': 'Historical Fiction',
        'status': 'Available',
        'isi_buku':
            'Majnun adalah kisah cinta, persahabatan, dan catatan atas sejarah yang dilupakan...',
        'gambar_sampul': 'assets/images/majnun_anton_kurnia.jpg'
      },
      {
        'judul': 'I Think I Love You',
        'penulis': 'Cha Mirae',
        'kategori': 'Young Adult Romance',
        'status': 'Available',
        'isi_buku':
            'Dua pria tampan di Kyunghee University, Jang Taehyun dan Han Seokjin, terlibat konflik...',
        'gambar_sampul': 'assets/images/i_think_i_love_you_cha_mirae.jpg'
      },
      {
        'judul': 'Where Stories Begin',
        'penulis': 'Wacaku',
        'kategori': 'Anthology',
        'status': 'Available',
        'isi_buku':
            'Antologi cerita pendek dari sepuluh penulis terpilih melalui perlombaan di tahun 2022...',
        'gambar_sampul': 'assets/images/where_stories_begin_wacaku.jpg'
      },
      {
        'judul': 'Ramai Yang Dulu Kita Bawa Pergi',
        'penulis': 'Suci Berliana',
        'kategori': 'Poetry & Reflection',
        'status': 'Available',
        'isi_buku':
            'Kilas balik pertemuan dan kenangan yang hanya bisa dijelaskan melalui rangkaian kata...',
        'gambar_sampul':
            'assets/images/ramai_yang_dulu_kita_bawa_pergi_suci_berliana.jpg'
      },
      {
        'judul': '172 Days',
        'penulis': 'Nadzira Shafa',
        'kategori': 'Romance',
        'status': 'Available',
        'isi_buku':
            'Kehidupan seorang wanita berubah dalam sekejap setelah kehilangan seseorang yang dicintai...',
        'gambar_sampul': 'assets/images/172_days_nadzira_shafa.jpg'
      },
      {
        'judul': 'Funiculi Funicula (Before the Coffee Gets Cold)',
        'penulis': 'Toshikazu Kawaguchi',
        'kategori': 'Magical Realism',
        'status': 'Available',
        'isi_buku':
            'Di sebuah kafe tua di Tokyo, pengunjung bisa menjelajahi waktu dengan syarat tertentu...',
        'gambar_sampul':
            'assets/images/funiculi_funicula_before_the_coffee_gets_cold_toshikazu_kawaguchi.jpg'
      },
      {
        'judul': 'Terpikat',
        'penulis': 'Ghefira Zakhira',
        'kategori': 'Teen Romance',
        'status': 'Available',
        'isi_buku':
            'Aruna jatuh cinta pada pandangan pertama kepada Abian, seorang siswa berprestasi yang sulit didekati...',
        'gambar_sampul': 'assets/images/terpikat_ghefira_zakhira.jpg'
      },
      {
        'judul': 'Oh My Savior',
        'penulis': 'Washashira',
        'kategori': 'Romance',
        'status': 'Available',
        'isi_buku':
            'Zelda, seorang gadis yang hidup serba kekurangan, menemukan cinta dalam sosok Zidane...',
        'gambar_sampul': 'assets/images/oh_my_savior_washashira.jpg'
      },
      {
        'judul': 'The Chronicles of Narnia #1: The Magicians Nephew',
        'penulis': 'C.S. Lewis',
        'kategori': 'Fantasy',
        'status': 'Available',
        'isi_buku':
            'Kisah tentang penciptaan dunia Narnia, di mana dua sahabat berpetualang melalui dunia lain...',
        'gambar_sampul':
            'assets/images/the_chronicles_of_narnia_1_the_magicians_nephew.jpg'
      },
      {
        'judul': 'Heartbreak Motel',
        'penulis': 'Ika Natassa',
        'kategori': 'Drama',
        'status': 'Available',
        'isi_buku':
            'Cerita tentang Ava, seorang aktris muda yang menghadapi perjalanan emosional dari masa lalu...',
        'gambar_sampul': 'assets/images/heartbreak_motel.jpg'
      },
      {
        'judul': 'The Chronicles of Narnia #3: The Horse & His Boy',
        'penulis': 'C.S. Lewis',
        'kategori': 'Fantasy',
        'status': 'Available',
        'isi_buku':
            'Empat pelarian bertemu dalam perjalanan penuh tantangan dan menemukan diri mereka di tengah pertempuran besar...',
        'gambar_sampul':
            'assets/images/the_chronicles_of_narnia_3_the_horse_and_his_boy.jpg'
      },
      {
        'judul': 'Sagaras',
        'penulis': 'Tere Liye',
        'kategori': 'Fantasy',
        'status': 'Available',
        'isi_buku':
            'Ali melanjutkan perjalanan untuk mengungkap misteri keluarganya, ditemani oleh sahabat sejati...',
        'gambar_sampul': 'assets/images/sagaras.jpg'
      }
    ];

    for (var book in booksData) {
      await booksCollection.add(book);
    }

    logger.i("✅ Seed data berhasil ditambahkan ke Firestore!");
  } catch (e) {
    logger.e("❌ Error saat melakukan seeding data: $e");
  }
}
