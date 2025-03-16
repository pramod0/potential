abstract class NativeStatusService {
  /// Checks if the native service is enabled.
  dynamic isServiceEnabled();

  /// Requests the user to enable the service if it is disabled.
  dynamic requestToEnableService();

  /// Handles errors that occur while checking or enabling the service.
  dynamic handleError(Exception e);

  /// Registers a listener to notify when the service status changes.
  dynamic addStatusChangeListener(Function(bool isEnabled) function);

  /// Removes the registered status change listener.
  dynamic removeStatusChangeListener();

  /// Checks if the necessary permissions for the service are granted.
  dynamic hasPermissions();

  /// Provides detailed information about the current service state.
  String getServiceStateDetails();
}
