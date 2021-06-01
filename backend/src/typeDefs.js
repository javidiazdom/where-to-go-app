import { gql } from 'apollo-server-express';

export const typeDefs = gql`
  type GeoLocation {
    type: String
    coordinates: [Float]
  }

  type Rating {
    rating: [Int]
  }

  type ProtocolRating {
    locationId: ID
    user: [User]
    ratings: [Rating]
  }

  type LocationHistory {
    location: Location
    date: String
  }

  type Location {
    geoLocation: GeoLocation
    name: String
    predictedAssistance: Int
    protocolRatings: [ProtocolRating]
  }

  type User {
    name: String
    email: String
    password: String
    locationHistory: [LocationHistory]
    ratingHistory: [ProtocolRating]
  }

  type Query {
    hello: String
    location(latlng: [Float]): Location
    locationRatings(location: LocationInput!): LocationRatings
  }

  input LocationInput {
    name: String
    coordinates: [Float]
  }

  type LoginOutput {
    user: User
    token: String
  }

  type StatusResponse {
    status: Boolean
    message: String
  }

  type LocationRatings {
    mainAverage: Float
    averagesCount: Int
    averages: [Float]
  }

  type Mutation {
    register(email: String!, password: String!, name: String!): Boolean
    login(email: String!, password: String!): LoginOutput
    addLocation(location: LocationInput!): Location
    noteForAssistance(location: LocationInput!): Location
    rateLocation(location: LocationInput!, ratings: [Float]!): StatusResponse
  }
`;
