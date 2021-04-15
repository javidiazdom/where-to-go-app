import { authController } from './controllers/auth.controller';

export const resolvers = {
  Query: {
    hello: () => 'Hello',
  },
  Mutation: {
    login: async (_, { email, password }, { res }) => {
      return await authController.login(email, password, res);
    },
    register: async (_, { email, password }) => {
      return await authController.registrer(email, password);
    },
  },
};
