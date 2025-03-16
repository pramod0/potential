abstract class StorageService {
  initializeStorage();

  clearStorage();

  saveValue(String key, String value);

  getValue(String key);

  updateValue(String key, String value);

  removeValue(String key);
}
