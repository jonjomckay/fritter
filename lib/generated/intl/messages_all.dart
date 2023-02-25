// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that looks up messages for specific locales by
// delegating to the appropriate library.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:implementation_imports, file_names, unnecessary_new
// ignore_for_file:unnecessary_brace_in_string_interps, directives_ordering
// ignore_for_file:argument_type_not_assignable, invalid_assignment
// ignore_for_file:prefer_single_quotes, prefer_generic_function_type_aliases
// ignore_for_file:comment_references

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';

import 'messages_ar.dart' as messages_ar;
import 'messages_be.dart' as messages_be;
import 'messages_be_Latn.dart' as messages_be_latn;
import 'messages_ca.dart' as messages_ca;
import 'messages_cs.dart' as messages_cs;
import 'messages_de.dart' as messages_de;
import 'messages_en.dart' as messages_en;
import 'messages_eo.dart' as messages_eo;
import 'messages_es.dart' as messages_es;
import 'messages_et.dart' as messages_et;
import 'messages_eu.dart' as messages_eu;
import 'messages_fr.dart' as messages_fr;
import 'messages_hi.dart' as messages_hi;
import 'messages_id.dart' as messages_id;
import 'messages_it.dart' as messages_it;
import 'messages_ja.dart' as messages_ja;
import 'messages_ko.dart' as messages_ko;
import 'messages_ml.dart' as messages_ml;
import 'messages_nb_NO.dart' as messages_nb_no;
import 'messages_nl.dart' as messages_nl;
import 'messages_or.dart' as messages_or;
import 'messages_pl.dart' as messages_pl;
import 'messages_pt_BR.dart' as messages_pt_br;
import 'messages_ro.dart' as messages_ro;
import 'messages_ru.dart' as messages_ru;
import 'messages_tr.dart' as messages_tr;
import 'messages_uk.dart' as messages_uk;
import 'messages_zh_Hans.dart' as messages_zh_hans;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
  'ar': () => new SynchronousFuture(null),
  'be': () => new SynchronousFuture(null),
  'be_Latn': () => new SynchronousFuture(null),
  'ca': () => new SynchronousFuture(null),
  'cs': () => new SynchronousFuture(null),
  'de': () => new SynchronousFuture(null),
  'en': () => new SynchronousFuture(null),
  'eo': () => new SynchronousFuture(null),
  'es': () => new SynchronousFuture(null),
  'et': () => new SynchronousFuture(null),
  'eu': () => new SynchronousFuture(null),
  'fr': () => new SynchronousFuture(null),
  'hi': () => new SynchronousFuture(null),
  'id': () => new SynchronousFuture(null),
  'it': () => new SynchronousFuture(null),
  'ja': () => new SynchronousFuture(null),
  'ko': () => new SynchronousFuture(null),
  'ml': () => new SynchronousFuture(null),
  'nb_NO': () => new SynchronousFuture(null),
  'nl': () => new SynchronousFuture(null),
  'or': () => new SynchronousFuture(null),
  'pl': () => new SynchronousFuture(null),
  'pt_BR': () => new SynchronousFuture(null),
  'ro': () => new SynchronousFuture(null),
  'ru': () => new SynchronousFuture(null),
  'tr': () => new SynchronousFuture(null),
  'uk': () => new SynchronousFuture(null),
  'zh_Hans': () => new SynchronousFuture(null),
};

MessageLookupByLibrary? _findExact(String localeName) {
  switch (localeName) {
    case 'ar':
      return messages_ar.messages;
    case 'be':
      return messages_be.messages;
    case 'be_Latn':
      return messages_be_latn.messages;
    case 'ca':
      return messages_ca.messages;
    case 'cs':
      return messages_cs.messages;
    case 'de':
      return messages_de.messages;
    case 'en':
      return messages_en.messages;
    case 'eo':
      return messages_eo.messages;
    case 'es':
      return messages_es.messages;
    case 'et':
      return messages_et.messages;
    case 'eu':
      return messages_eu.messages;
    case 'fr':
      return messages_fr.messages;
    case 'hi':
      return messages_hi.messages;
    case 'id':
      return messages_id.messages;
    case 'it':
      return messages_it.messages;
    case 'ja':
      return messages_ja.messages;
    case 'ko':
      return messages_ko.messages;
    case 'ml':
      return messages_ml.messages;
    case 'nb_NO':
      return messages_nb_no.messages;
    case 'nl':
      return messages_nl.messages;
    case 'or':
      return messages_or.messages;
    case 'pl':
      return messages_pl.messages;
    case 'pt_BR':
      return messages_pt_br.messages;
    case 'ro':
      return messages_ro.messages;
    case 'ru':
      return messages_ru.messages;
    case 'tr':
      return messages_tr.messages;
    case 'uk':
      return messages_uk.messages;
    case 'zh_Hans':
      return messages_zh_hans.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) {
  var availableLocale = Intl.verifiedLocale(
      localeName, (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return new SynchronousFuture(false);
  }
  var lib = _deferredLibraries[availableLocale];
  lib == null ? new SynchronousFuture(false) : lib();
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return new SynchronousFuture(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary? _findGeneratedMessagesFor(String locale) {
  var actualLocale =
      Intl.verifiedLocale(locale, _messagesExistFor, onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
