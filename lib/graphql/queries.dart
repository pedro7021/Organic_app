import 'package:organic/graphql/fragments.dart';

class Queries {
  static const FIND_ADS = """
  query FIND_ADS(
    \$latitude: Float!
    \$longitude: Float!
    \$distance: Float!
  ) {
    findNearby(
      geolocation: {
        latitude: \$latitude
        longitude: \$longitude
        distance: \$distance
      }
    ) {
      ${Fragments.NEARBY_AD}
    }
  }
  """;
  static const FIND_ADS_BY_USER = """
  query FIND_ADS_BY_USER {
    findUserAds {
      ${Fragments.NEARBY_AD}
    }
  }
  """;
  static const FIND_ADS_BY_CATEGORY = """
  query FIND_ADS_BY_CATEGORY(
    \$latitude: Float!
    \$longitude: Float!
    \$distance: Float!
    \$category: String!
  ) {
    findNearby(
      geolocation: {
        latitude: \$latitude
        longitude: \$longitude
        distance: \$distance
      }
      where: { category: \$category }
    ) {
      ${Fragments.NEARBY_AD}
    }
  }
  """;
  static const FIND_ADS_BY_QUERY = """
  query FIND_ADS_BY_QUERY(
    \$latitude: Float!
    \$longitude: Float!
    \$distance: Float!
    \$query: String!
  ) {
    findNearby(
      geolocation: {
        latitude: \$latitude
        longitude: \$longitude
        distance: \$distance
      }
      where: { title_contains: \$query }
    ) {
      ${Fragments.NEARBY_AD}
    }
  }
  """;
}
