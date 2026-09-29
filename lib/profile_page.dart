import 'package:flutter/material.dart';
import 'food_item.dart';

class ProfilePage extends StatelessWidget {
  final List<FoodItem> foods;
  const ProfilePage({super.key, required this.foods});

  static const String customerName = 'NATHIQ';

  @override
  Widget build(BuildContext context) {
    final totalPorsi = foods.fold<int>(0, (s, f) => s + f.quantity);
    final totalHarga = foods.fold<int>(0, (s, f) => s + f.totalPrice);

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Profil', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 44,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.person,
                  size: 48, color: Color(0xFF1976D2)),
            ),
            const SizedBox(height: 12),
            const Text(customerName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Pelanggan Resto',
                style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 24),
            _InfoTile(
              icon: Icons.restaurant_menu,
              title: 'Menu Resto',
              subtitle: 'Pesan makanan favorit Anda dengan mudah.',
            ),
            _InfoTile(
              icon: Icons.receipt_long,
              title: 'Pemesanan',
              subtitle:
                  '$totalPorsi porsi • Total Rp ${formatPrice(totalHarga)}',
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _InfoTile(
      {required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: const Color(0xFF1976D2)),
        ),
        title:
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
