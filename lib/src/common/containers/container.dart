/// Container provides namespace resolution for types, functions, and variables.
///
/// The container system works like C++ namespaces, allowing unqualified names
/// to be resolved within a namespace hierarchy.
class Container {
  final String name;
  final Map<String, String> aliases;

  Container({this.name = '', this.aliases = const {}});

  /// Extend creates a new Container with existing settings and applies options.
  Container extend({String? name, Map<String, String>? additionalAliases}) {
    return Container(
      name: name ?? this.name,
      aliases: {...this.aliases, ...?additionalAliases},
    );
  }

  /// ResolveCandidateNames returns candidate names for namespace resolution.
  ///
  /// For a container "a.b.c" and name "R.s", returns:
  /// - a.b.c.R.s
  /// - a.b.R.s
  /// - a.R.s
  /// - R.s
  ///
  /// If the name starts with ".", it's already fully qualified.
  List<String> resolveCandidateNames(String name) {
    // Handle fully qualified names (starting with '.')
    if (name.startsWith('.')) {
      final qualifiedName = name.substring(1);
      final alias = aliases[qualifiedName];
      if (alias != null) {
        return [alias];
      }
      return [qualifiedName];
    }

    // Check for alias first
    final alias = aliases[name];
    if (alias != null) {
      return [alias];
    }

    // If no container, just return the name
    if (this.name.isEmpty) {
      return [name];
    }

    // Build candidate list from most specific to least specific
    final candidates = <String>[];
    final parts = this.name.split('.');

    // Start with the full container name
    for (int i = parts.length; i >= 0; i--) {
      if (i == parts.length) {
        // Full container name
        candidates.add('${this.name}.$name');
      } else if (i > 0) {
        // Partial container name
        final partial = parts.sublist(0, i).join('.');
        candidates.add('$partial.$name');
      } else {
        // No container
        candidates.add(name);
      }
    }

    return candidates;
  }

  /// Find an alias for the given name
  String? findAlias(String name) {
    return aliases[name];
  }
}

/// Default empty container
final defaultContainer = Container();
