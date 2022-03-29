import 'package:graphql/client.dart';
import 'package:organic/graphql/mutations.dart';
import 'package:organic/graphql/queries.dart';
import 'package:organic/models/user.dart';

final publicLink = HttpLink(
  'https://organic-api-i4ht3h4sba-rj.a.run.app/graphql',
);

final policies = Policies(
  fetch: FetchPolicy.noCache,
);

final GraphQLClient PublicClient = GraphQLClient(
  cache: GraphQLCache(),
  link: publicLink,
  defaultPolicies: DefaultPolicies(
    watchQuery: policies,
    query: policies,
    mutate: policies,
  ),
);

GraphQLClient AuthorizedClient(String token) {
  return GraphQLClient(
    cache: GraphQLCache(),
    link: AuthLink(
      getToken: () async => 'Bearer $token',
    ).concat(publicLink),
    defaultPolicies: DefaultPolicies(
      watchQuery: policies,
      query: policies,
      mutate: policies,
    ),
  );
}

Future<QueryResult> query(
  GraphQLClient client,
  String query,
  Map<String, dynamic> variables,
) async {
  return client.query(
    QueryOptions(document: gql(query), variables: variables),
  );
}

Future<QueryResult> mutation(
  GraphQLClient client,
  String mutation,
  Map<String, dynamic> variables,
) async {
  return client.mutate(
    MutationOptions(
      document: gql(mutation),
      variables: variables,
    ),
  );
}

class Perform {
  Future<QueryResult> Forgot_Password(String email) {
    return mutation(PublicClient, Mutations.FORGOT_PASSWORD, {"email": email});
  }

  Future<QueryResult> Delete_Ad(String id, String UserToken) {
    return mutation(
        AuthorizedClient(UserToken), Mutations.DELETE_AD, {"id": id});
  }

  Future<QueryResult> Buy_Boost(
      String id, String UserToken, String PurchaseToken) {
    return mutation(AuthorizedClient(UserToken), Mutations.BUY_BOOST,
        {"id": id, "token": PurchaseToken});
  }

  Future<QueryResult> Authenticate_User(User user) {
    return mutation(PublicClient, Mutations.AUTHENTICATE_USER, user.toMap());
  }

  Future<QueryResult> Create_User(User user) {
    return mutation(PublicClient, Mutations.CREATE_USER, user.toMap());
  }

  Future<QueryResult> Create_Complaint(Map<String, dynamic> complaint) {
    return mutation(PublicClient, Mutations.CREATE_COMPLAINT, complaint);
  }

  Future<QueryResult> Find_Ads(
    double latitude,
    double longitude,
    double distance,
  ) {
    return query(PublicClient, Queries.FIND_ADS, {
      "latitude": latitude,
      "longitude": longitude,
      "distance": distance,
    });
  }

  Future<QueryResult> Find_Ads_By_User(
    String UserToken,
  ) {
    return query(AuthorizedClient(UserToken), Queries.FIND_ADS_BY_USER, {});
  }

  Future<QueryResult> Find_Ads_By_Category(
    double latitude,
    double longitude,
    double distance,
    String category,
  ) {
    return query(
      PublicClient,
      Queries.FIND_ADS_BY_CATEGORY,
      {
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
        "category": category,
      },
    );
  }

  Future<QueryResult> Find_Ads_By_Query(
    double latitude,
    double longitude,
    double distance,
    String search,
  ) {
    return query(
      PublicClient,
      Queries.FIND_ADS_BY_QUERY,
      {
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
        "query": search,
      },
    );
  }
}
