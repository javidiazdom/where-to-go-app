import { authController } from './controllers/auth.controller';
import { locationController } from './controllers/location.controller';

export const resolvers = {
  Query: {
    hello: () => 'Hello',
    location: async (_, { latlng }, { auth }) => {
      return await authController.requireAuth(
        auth,
        locationController.getLocation,
        latlng
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
  },
};
