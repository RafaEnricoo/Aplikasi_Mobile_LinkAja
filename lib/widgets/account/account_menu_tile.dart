import 'package:flutter/material.dart';

class AccountMenuTile extends StatelessWidget {
  final IconData? icon; // Ubah jadi nullable (boleh null)
  final String? iconAsset; // Tambahan: Buat nerima path gambar
  final String title;
  final String? trailingText;
  final VoidCallback onTap;

  const AccountMenuTile({
    super.key,
    this.icon, // Gak wajib required lagi
    this.iconAsset, // Parameter baru
    required this.title,
    this.trailingText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            // --- LOGIKA ICON vs GAMBAR ---
            // Cek: Kalau iconAsset ada isinya, pake Image.asset
            if (iconAsset != null)
              Image.asset(
                iconAsset!,
                width: 24, // Samain ukurannya kayak icon biasa
                height: 24,
                fit: BoxFit.contain,
              )
            // Kalau gak ada aset, pake Icon biasa
            else
              Icon(icon, size: 24, color: Colors.black87),

            // -----------------------------
            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            if (trailingText != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  trailingText!,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ),

            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.red.shade700),
          ],
        ),
      ),
    );
  }
}
