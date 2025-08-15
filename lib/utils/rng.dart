import 'dart:math';

final _rng = Random();

int roll(int min, int max) => min + _rng.nextInt((max - min) + 1);

double rollDouble() => _rng.nextDouble();
