import 'package:advanced_flutter_arabic/data/network/error_handler.dart';
import 'package:advanced_flutter_arabic/data/responses/responses.dart';

const cacheHomeKey = "CACHE_HOME_KEY";
const cacheStoreDetailsKey = "CACHE_Store_Details_KEY";
const cacheHomeInterval = 60000; //1 min in millis
const cacheStoreDetailsInterval = 120000; //2 min in millis

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

  Future<StoreDetailsResponse> getStoreDetails();

  Future<void> saveHomeToCache(HomeResponse homeResponse);

  Future<void> saveStoreDetailsToCache(StoreDetailsResponse storeDetailsResponse);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  //run time cache
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cacheMap[cacheHomeKey];

    if (cachedItem != null && cachedItem.isValid(cacheHomeInterval)) {
      //return the response from cache
      return cachedItem.data;
    } else {
      //return an error that cache is no there or it's not valid
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails()  async {
    CachedItem? cachedItem = cacheMap[cacheStoreDetailsKey];

    if (cachedItem != null && cachedItem.isValid(cacheStoreDetailsInterval)) {
      //return the response from cache
      return cachedItem.data;
    } else {
      //return an error that cache is no there or it's not valid
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse storeDetailsResponse) async {
    cacheMap[cacheStoreDetailsKey] = CachedItem(storeDetailsResponse);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTimeInMillis - cacheTime < expirationTimeInMillis;
    return isValid;
  }
}
