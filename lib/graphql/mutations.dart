import 'package:organic/graphql/fragments.dart';

class Mutations {
  static const FORGOT_PASSWORD = """
  mutation FORGOT_PASSWORD(\$email:String!) {
    forgotPassword(email:\$email){
      ok
    }
  }
  """;
  static const DELETE_AD = """
  mutation DELETE_AD(\$id: ID!) {
    removeAd(id: \$id) {
      ${Fragments.AD}
    }
  }
  """;
  static const BUY_BOOST = """
  mutation BUY_BOOST(\$id: ID!,\$token: String!) {
    buyBoost(id: \$id,token:\$token) {
      ${Fragments.AD}
    }
  }
  """;
  static const AUTHENTICATE_USER = """
  mutation AUTHENTICATE_USER(\$email: String!, \$password: String!) {
    login(input: { identifier: \$email, password: \$password }) {
      ${Fragments.USER}
    }
  }
  """;
  static const CREATE_USER = """
  mutation CREATE_USER(\$username: String!, \$email: String!, \$password: String!) {
    register(input: { username: \$username, email: \$email, password: \$password }) {
      ${Fragments.USER}
    }
  }
  """;
  static const CREATE_COMPLAINT = """
    mutation CREATE_COMPLAINT(\$email: String,\$ad:ID,\$topic: String!,\$description: String!) {
    createComplaint(input:{data:{email:\$email,topic:\$topic,description:\$description,ad:\$ad}}){
      complaint {
        id
      }
    }
  }
  """;

}
