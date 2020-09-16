import 'networking.dart';

const apiKey = 'keydmio6pXZIzqESb';

class RestaurantModel {
  Future<dynamic> getRestaurantList() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.airtable.com/v0/appevIrbwOCcGQfYi/Imported%20table?&api_key=$apiKey&filterByFormula=NOT%28%7BDescription%7D%20%3D%20%27%27%29');

    var restaurantData = await networkHelper.getData();
    return restaurantData;
  }

  Future<dynamic> getRestaurantSearch(searchValue) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.airtable.com/v0/appevIrbwOCcGQfYi/Imported%20table?&api_key=$apiKey&filterByFormula=AND%28FIND%28UPPER%28%27$searchValue%27%29%2C+UPPER%28CONCATENATE%28%7BName%7D%2C+%7BDescription%7D%2C+%7BLocation%7D%2C+%7BCuisine%7D%29%29%29%2CNOT%28%7BDescription%7D+%3D+%27%27%29%29');

    var restaurantData = await networkHelper.getData();
    return restaurantData;
  }

  Future<dynamic> getRestaurantItem(id) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.airtable.com/v0/appevIrbwOCcGQfYi/Imported%20table/$id?&api_key=$apiKey');

    var restaurantData = await networkHelper.getData();
    return restaurantData;
  }

  Future<dynamic> updateRestaurantItem(id, jsonBody) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.airtable.com/v0/appevIrbwOCcGQfYi/Imported%20table/$id?&api_key=$apiKey');

    var restaurantData = await networkHelper.updateData(jsonBody);
    return restaurantData;
  }
}
