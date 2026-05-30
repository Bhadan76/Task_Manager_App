import 'package:crup_app/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../update_product_screen.dart';
import '../utils/url.dart';

class ProductItem extends StatefulWidget {
  final product item;
  final VoidCallback refeshProductList;
  const ProductItem({
    super.key,
    required this.item,
    required this.refeshProductList,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _deleteInProgress = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        widget.item.image,
        width: 50,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error_outline, size: 30);
        },
      ),
      title: Text(
        widget.item.productName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Code: ${widget.item.productCode}'),
          Row(
            children: [
              Text('Qty: ${widget.item.quentity}'),
              const SizedBox(width: 16),
              Text('Price: ${widget.item.unitPrice}'),
            ],
          ),
        ],
      ),
      trailing: _deleteInProgress
          ? const CircularProgressIndicator()
          : PopupMenuButton<productOption>(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(value: productOption.update, child: Text('Update')),
                  const PopupMenuItem(value: productOption.delete, child: Text('Delete')),
                ];
              },
              onSelected: (productOption selectedOption) async {
                if (selectedOption == productOption.delete) {
                  _showDeleteConfirmationDialog();
                } else if (selectedOption == productOption.update) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateProductScreen(item: widget.item),
                    ),
                  );
                  widget.refeshProductList();
                }
              },
            ),
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteProduct();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct() async {
    _deleteInProgress = true;
    if (mounted) setState(() {});

    try {
      Uri uri = Uri.parse(url.deleteProductUrl(widget.item.id));
      Response response = await get(uri);
      
      if (response.statusCode == 200) {
        widget.refeshProductList();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to delete product'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      _deleteInProgress = false;
      if (mounted) setState(() {});
    }
  }
}

enum productOption { update, delete }
