class LocationServiceException implements Exception {}

class LocationServiceDisabledException extends LocationServiceException {}

class LocationServiceDeniedException extends LocationServiceException {}

class LocationServiceDeniedForeverException extends LocationServiceException {}

class CompassException implements Exception {}

class CompassNotFoundException extends CompassException {}
