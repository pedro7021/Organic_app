class Fragments {
  static const USER = """
    jwt
    user {
      id
      username
      email
    }
  """;
  static const NEARBY_AD = """
    id
    title
    description
    price
    category
    measure
    phone
    images {
      url
    }
    isBoosted
  """;
  static const AD = """
    id
    title
    description
    price
    category
    measure
    phone
    images {
      url
    }
  """;
}