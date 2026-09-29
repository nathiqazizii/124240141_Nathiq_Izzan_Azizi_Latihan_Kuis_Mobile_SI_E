import 'package:flutter/material.dart';
import 'food_item.dart';

class DetailPage extends StatefulWidget {
  final FoodItem food;
  const DetailPage({super.key, required this.food});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final TextEditingController _controller;
  late int _qty;

  @override
  void initState() {
    super.initState();
    _qty = widget.food.quantity;
    _controller = TextEditingController(text: '$_qty');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setQty(int value) {
    if (value < 0) value = 0;
    setState(() => _qty = value);
    _controller.text = '$value';
    _controller.selection =
        TextSelection.collapsed(offset: _controller.text.length);
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.food;
    final total = _qty * f.price;

    return Scaffold(
      appBar: AppBar(
        title: Text(f.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: f.name,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                f.imageUrl,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 220,
                  color: Colors.blue.shade100,
                  child: const Icon(Icons.fastfood,
                      color: Colors.blue, size: 60),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(f.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Rp ${f.formattedPrice} / porsi',
                      style: const TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(f.description,
                      style: TextStyle(color: Colors.grey.shade700)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      IconButton.filledTonal(
                        onPressed: () => _setQty(_qty - 1),
                        icon: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            labelText: 'Jumlah (porsi)',
                            prefixIcon: Icon(Icons.format_list_numbered),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (v) =>
                              setState(() => _qty = int.tryParse(v) ?? 0),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filledTonal(
                        onPressed: () => _setQty(_qty + 1),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 16)),
                      Text('Rp ${formatPrice(total)}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32))),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () => Navigator.pop(context, _qty),
            icon: const Icon(Icons.shopping_cart),
            label: const Text('Simpan Pemesanan'),
          ),
        ],
      ),
    );
  }
}
