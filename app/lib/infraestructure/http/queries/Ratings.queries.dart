var getLocationRatingsQuery = r'''
query ($name: String!, $coordinates: [Float]!) {
  locationRatings(location: {name: $name, coordinates: $coordinates}) {
    mainAverage
    averagesCount
    averages
  }
}
''';
