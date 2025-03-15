// arquivo: tamanhos_fontes.dart
import 'package:flutter/material.dart';

/// Enumeração que define os tamanhos padrão de fontes para a aplicação.
enum FontSize {
  /// Tamanho pequeno: ideal para textos secundários ou legendas.
  Small,

  /// Tamanho médio: utilizado para o corpo do texto.
  Medium,

  /// Tamanho grande: recomendado para títulos ou destaques.
  Large,

  header,
}

/// Extensão que associa cada [FontSize] a um valor numérico correspondente.
extension TamanhoFonteExtension on FontSize {
  /// Retorna o valor em pontos (pt) correspondente ao tamanho da fonte.
  double get value {
    switch (this) {
      case FontSize.Small:
        return 14.0;
      case FontSize.Medium:
        return 18.0;
      case FontSize.Large:
        return 24.0;
        case FontSize.header:
        return 32.0; // Defina um tamanho maior para cabeçalhos
    }
  }
}
