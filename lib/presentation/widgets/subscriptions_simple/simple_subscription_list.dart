import 'package:flutter/material.dart';
import '../../../domain/entities/subscription.dart';
import 'simple_subscription_card.dart';

class SimpleSubscriptionList extends StatelessWidget {
  final List<Subscription> subscriptions;
  final Function(Subscription)? onTap;

  const SimpleSubscriptionList({
    super.key,
    required this.subscriptions,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        return SimpleSubscriptionCard(
          subscription: subscriptions[index],
          onTap: onTap != null ? () => onTap!(subscriptions[index]) : null,
        );
      },
    );
  }
}
