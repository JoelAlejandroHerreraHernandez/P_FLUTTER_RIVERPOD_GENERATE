import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_app/config/config.dart';

part 'future_providers.g.dart';

@Riverpod(keepAlive: true)
Future<String> pokemonName(Ref ref) async {

  final pokemonId = ref.watch(pokemonIdProvider);
  final pokemonName = await PokemonInformation.getPokemonName(pokemonId);
  
  ref.onDispose(() {
    print('Disposed');
  });
  
  return pokemonName;
}

@Riverpod(keepAlive: true)
class PokemonId extends _$PokemonId {
  @override
  int build() {
    return 1;
  }

  void nextPokemon() {
    state++;
  }

  void previousPokemon() {
    if (state > 1) state--;
  }
}


@Riverpod(keepAlive: true)
Future<String> pokemon(Ref ref, int id) async {
  final pokemonName = await PokemonInformation.getPokemonName(id);
  return pokemonName;
}