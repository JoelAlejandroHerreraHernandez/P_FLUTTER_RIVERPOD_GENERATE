import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/future_providers.dart';


class FamilyFutureScreen extends ConsumerStatefulWidget {
  const FamilyFutureScreen({super.key});

  @override
  FamilyFutureScreenState createState() => FamilyFutureScreenState();
}

class FamilyFutureScreenState extends ConsumerState<FamilyFutureScreen> {

  int pokemonId = 1;

  @override
  Widget build(BuildContext context) {

    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Future Provider'),
      ),
      body: Center(
        child: pokemonAsync.when(
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
              if (pokemonId <= 1) return;
              pokemonId--;
              setState(() {});
            },
          ),
          const SizedBox( height: 10 ),

          FloatingActionButton(
            child: const Icon( Icons.navigate_next ),
            onPressed: () {
              pokemonId++;
              setState(() {});
            },
          ),

        ],
      ),

    );
  }
}