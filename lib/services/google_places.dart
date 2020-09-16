import 'networking.dart';

const apiKey = 'AIzaSyCoRNrpc1qYAW5UQmZcONFQDuY0-K1gzFs';
const fields =
    'rating,user_ratings_total,photo,opening_hours,reviews,formatted_phone_number';

class GooglePlace {
  Future<dynamic> getPlaceDetails(placeID) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&fields=$fields&key=$apiKey&language=en');

    var placeData = await networkHelper.getData();
    return placeData;
  }

  Future<dynamic> findPlaces(placeName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$placeName&inputtype=textquery&fields=place_id&key=$apiKey');

    var placeData = await networkHelper.getData();
    return placeData;
  }
}
