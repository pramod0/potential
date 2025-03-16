abstract class PermissionService {
  // Method to check if permission is granted
  Future<bool> isPermissionGranted();

  // Method to request permission
  Future<bool> requestPermission();

  // Method to check permission status
  Future<bool> checkAndRequestPermission();
}
