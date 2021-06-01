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

const String addPlaceMutation = r'''
  mutation ($name: String!, $coordinates: [Float]!) {
    addLocation (location: {coordinates: $coordinates, name: $name}) {
      geoLocation {
        coordinates
      }
      name
      predictedAssistance
    }
  }
''';

const String noteForAssistanceMutation = r'''
  mutation ($name: String!, $coordinates: [Float]!) {
    noteForAssistance(location: {coordinates: $coordinates, name: $name}) {
      geoLocation {
        coordinates
      }
      name
      predictedAssistance
    }
  }
''';

const String rateLocationMutation = r'''
  mutation ($name: String!, $coordinates: [Float]!, $ratings: [Float]!) {
    rateLocation(location: {name: $name, coordinates: $coordinates} ratings: $ratings) {
      status 
      message
    }
  }
''';
