class Buku {
  final String id;
  final String judul;
  final String penulis;
  final String kategori;
  final String status;
  final String isiBuku;
  final String gambarSampul;

  Buku({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.kategori,
    required this.status,
    required this.isiBuku,
    required this.gambarSampul,
  });

  // Convert Firestore document ke object Buku
  factory Buku.fromMap(Map<String, dynamic> map, String documentId) {
    return Buku(
      id: documentId,
      judul: map['judul'] ?? '',
      penulis: map['penulis'] ?? '',
      kategori: map['kategori'] ?? '',
      status: map['status'] ?? 'Tersedia',
      isiBuku: map['isi_buku'] ?? '',
      gambarSampul: map['gambar_sampul'] ?? '',
    );
  }

  // Convert object ke Map untuk Firestore
  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'penulis': penulis,
      'kategori': kategori,
      'status': status,
      'isi_buku': isiBuku,
      'gambar_sampul': gambarSampul,
    };
  }
}
