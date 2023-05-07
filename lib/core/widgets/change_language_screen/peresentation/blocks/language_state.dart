import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


class LanguageState extends Equatable{
  Locale? locale;

  LanguageState(
      {
        this.locale,
      }
      );
  @override
  List<Locale?> get props => [locale];
}
