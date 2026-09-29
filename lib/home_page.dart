import 'package:flutter/material.dart';
import 'food_item.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  final List<FoodItem> foods;
  final VoidCallback onChanged;

  const HomePage({super.key, required this.foods, required this.onChanged});

  Future<void> _openDetail(BuildContext context, FoodItem food) async {
    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(builder: (_) => DetailPage(food: food)),
    );
    if (result != null) {
      food.quantity = result;
      onChanged(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Resto',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: foods.length,
        itemBuilder: (context, i) {
          final f = foods[i];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              onTap: () => _openDetail(context, f),
              child: SizedBox(
                height: 110,
                child: Row(
                  children: [
                    Hero(
                      tag: f.name,
                      child: Image.network(
                        f.imageUrl,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 110,
                          color: Colors.blue.shade100,
                          child: const Icon(Icons.fastfood,
                              color: Colors.blue, size: 40),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(f.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  const SizedBox(height: 2),
                                  Text(f.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade600)),
                                  const Spacer(),
                                  Text('${f.quantity} porsi',
                                      style: const TextStyle(
                                          color: Color(0xFF1976D2),
                                          fontWeight: FontWeight.bold)),
                                  Text('Rp ${f.formattedPrice} / porsi',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade500)),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text('Rp ${f.formattedTotal}',
                                  style: const TextStyle(
                                      color: Color(0xFF2E7D32),
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
