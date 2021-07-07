import { authController } from './controllers/auth.controller';
import { locationController } from './controllers/location.controller';
import { protocolRatingController } from './controllers/protocolRating.controller';

export const resolvers = {
  Query: {
    location: async (_, { latlng }, { auth }) => {
      return await authController.requireAuth(
        auth,
        locationController.getLocation,
        latlng
      );
    },
    locationRatings: async (_, { location }, { auth }) => {
      return await authController.requireAuth(
        auth,
        protocolRatingController.getLocationRatingsAverages,
        location
      );
    },
  },
  Mutation: {
    login: async (_, { email, password }, { auth }) => {
      return await authController.login(email, password, auth);
    },
    register: async (_, { email, password, name }) => {
      return await authController.register(email, password, name);
    },
    addLocation: async (_, { location }, { auth }) => {
      return await authController.requireAuth(
        auth,
        locationController.addLocation,
        location
      );
    },
    noteForAssistance: async (_, { location }, { auth }) => {
      return await authController.requireAuth(
        auth,
        locationController.noteForAssistance,
        location
      );
    },
    rateLocation: async (_, { location, ratings }, { auth }) => {
      return await authController.requireAuth(
        auth,
        protocolRatingController.rateLocation,
        { location: location, ratings: ratings }
      );
    },
  },
};
