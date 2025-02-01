import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../models/buku.dart';
import '../viewmodels/books_viewmodel.dart';
// import 'reading_page.dart';

class AddEditPage extends StatefulWidget {
  final Buku? buku;

  const AddEditPage({super.key, this.buku});

  @override
  AddEditPageState createState() => AddEditPageState();
}

class AddEditPageState extends State<AddEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _penulisController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _statusController = TextEditingController();
  final _isiBukuController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.buku != null) {
      _judulController.text = widget.buku!.judul;
      _penulisController.text = widget.buku!.penulis;
      _kategoriController.text = widget.buku!.kategori;
      _statusController.text = widget.buku!.status;
      _isiBukuController.text = widget.buku!.isiBuku;
    } else {
      _statusController.text = 'Tersedia';
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      String fileName = 'covers/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bukuViewModel = Provider.of<BukuViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.buku == null ? 'Tambah Buku' : 'Edit Buku')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_selectedImage != null)
                Image.file(_selectedImage!, height: 150, fit: BoxFit.cover)
              else
                Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: const Center(child: Text('No Cover Image')),
                ),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Pilih Gambar Sampul'),
              ),
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Masukkan judul' : null,
              ),
              TextFormField(
                controller: _penulisController,
                decoration: const InputDecoration(labelText: 'Penulis'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Masukkan penulis' : null,
              ),
              TextFormField(
                controller: _kategoriController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              TextFormField(
                controller: _isiBukuController,
                decoration: const InputDecoration(labelText: 'Isi Buku'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String? imageUrl;
                    if (_selectedImage != null) {
                      imageUrl = await _uploadImage(_selectedImage!);
                    }

                    final newBuku = Buku(
                      id: widget.buku?.id ?? '',
                      judul: _judulController.text,
                      penulis: _penulisController.text,
                      kategori: _kategoriController.text,
                      status: _statusController.text,
                      isiBuku: _isiBukuController.text,
                      gambarSampul: imageUrl ?? widget.buku?.gambarSampul ?? '',
                    );

                    final bukuViewModel =
                        Provider.of<BukuViewModel>(context, listen: false);

                    if (widget.buku == null) {
                      await bukuViewModel.tambahBuku(newBuku);
                    } else {
                      await bukuViewModel.editBuku(newBuku);
                    }

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(widget.buku == null ? 'Simpan' : 'Perbarui'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
