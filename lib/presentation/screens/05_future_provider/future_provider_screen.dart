import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/future_providers.dart';


class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final pokemonName = ref.watch(pokemonNameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Provider'),
      ),
      body:  Center(
        child: pokemonName.when(
          data: (data) => Text(data),
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'back',
            child: const Icon( Icons.navigate_before ),
            onPressed: () {
              ref.read(pokemonIdProvider.notifier).previousPokemon();
            },
          ),
          const SizedBox( height: 10 ),

          FloatingActionButton(
            child: const Icon( Icons.navigate_next ),
            onPressed: () {
              ref.read(pokemonIdProvider.notifier).nextPokemon();
            },
          ),

        ],
      ),
    );
  }
}


