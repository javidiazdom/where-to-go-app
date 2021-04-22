const String loginMutation = r'''
  mutation login ($email: String!, $password: String!) {
    login (email: $email, password: $password) {
      token
      user {
        name
      }
    }
  }
''';

const String registerMutation = r'''
  mutation register ($email: String!, $password: String!, $name: String!) {
    register (email: $email, password: $password, name: $name)
  }
''';
