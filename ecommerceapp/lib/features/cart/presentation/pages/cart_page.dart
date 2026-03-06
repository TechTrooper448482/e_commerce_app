import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_tile.dart';

part 'cart_page_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageState();
}
