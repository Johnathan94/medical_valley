class Flavor {
  String baseUrl ;
  String version ;
  Flavor(this.baseUrl, this.version);
}
class FlavorManager {
  static late Flavor _currentFlavor ;
  static setCurrentFlavor (Flavor newFlavor ){
    _currentFlavor = newFlavor;
    _currentFlavor.baseUrl += _currentFlavor.version;
  }

  static Flavor get currentFlavor => _currentFlavor;
}