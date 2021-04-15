import { gql } from 'apollo-server-express';

export const typeDefs = gql`
  type LatLng {
    lattitude: Float
    longitude: Float
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
    coordinates: LatLng
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
    locations: [Location]
  }

  input LatLngInput {
    lattitude: Float
    longitude: Float
  }

  type LoginOutput {
    user: User
    token: String
  }

  type Error {
    code: Int
    status: String
  }

  type Mutation {
    createLocation(
      name: String!
      coordinates: LatLngInput
      predictedAssistance: Int
    ): Location!
    noteForAssistance(locationCoordinates: LatLngInput!): Boolean!
    register(email: String!, password: String!): Boolean
    login(email: String!, password: String!): LoginOutput
  }
`;