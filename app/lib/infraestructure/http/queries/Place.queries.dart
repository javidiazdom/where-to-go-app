const placeQuery = r'''
query ($latlng:[Float]!) {
  location(latlng: $latlng) {
    geoLocation{
      coordinates
    }
    name
    predictedAssistance
    protocolRatings {
      ratings {
        rating
      }
    }
  }
}''';
