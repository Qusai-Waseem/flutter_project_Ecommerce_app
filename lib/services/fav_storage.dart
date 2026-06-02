import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/product.dart';

class FavoritesStorage {
  // جلب ملف التخزين المحلي
  static Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/favorites.json');
  }

  // قراءة المفضلة من الملف
  static Future<List<Product>> loadFavorites() async {
    try {
      final file = await _getFile();

      if (!await file.exists()) {
        return [];
      }

      final content = await file.readAsString();

      final List data = jsonDecode(content);

      return data.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      // لو صار أي خطأ
      return [];
    }
  }

  // حفظ المفضلة
  static Future<void> saveFavorites(List<Product> favorites) async {
    try {
      final file = await _getFile();

      final data = favorites.map((p) {
        return {
          "id": p.id,
          "title": p.title,
          "image": p.image,
          "price": p.price,
        };
      }).toList();

      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      // تجاهل الخطأ (graceful handling)
    }
  }
}