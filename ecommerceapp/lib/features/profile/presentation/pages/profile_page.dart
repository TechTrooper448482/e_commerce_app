import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/order_entity.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) {
        return;
      }
      context.read<ProfileProvider>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Scaffold(
      body: profile.isLoading
          ? const Center(child: CircularProgressIndicator())
          : profile.profile == null
              ? const Center(child: Text('No profile data.'))
              : SafeArea(
                child: ListView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    children: [
                      Text(
                        'Profile',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage your account and orders.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      _buildHeader(context, profile),
                      const SizedBox(height: 32),
                      Text(
                        'Order history',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      ...profile.orders.map(
                        (order) => _OrderTile(
                          order: order,
                          onReorder: () => profile.reorder(order.id),
                          onCancel: order.status == 'Cancelled'
                              ? null
                              : () => profile.cancelOrder(order.id),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Settings (mock)',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      const ListTile(
                        leading: Icon(Icons.lock_outline),
                        title: Text('Change password'),
                        subtitle: Text('Integrate your security flow here.'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.notifications_outlined),
                        title: Text('Notifications'),
                        subtitle: Text('Connect to your notification settings.'),
                      ),
                    ],
                  ),
              ),
    );
  }

  Widget _buildHeader(BuildContext context, ProfileProvider profile) {
    final user = profile.profile!.user;

    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          child: Text(
            user.name.characters.first.toUpperCase(),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              user.email,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({
    required this.order,
    required this.onReorder,
    required this.onCancel,
  });

  final OrderEntity order;
  final VoidCallback onReorder;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order.id}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${order.status} • ${order.date.toLocal().toString().split(' ').first}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${order.total.toStringAsFixed(2)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: onReorder,
                    child: const Text('Re-order'),
                  ),
                  if (onCancel != null)
                    TextButton(
                      onPressed: onCancel,
                      child: const Text('Cancel'),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

