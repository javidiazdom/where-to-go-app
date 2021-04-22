import { authController } from './controllers/auth.controller';

export const resolvers = {
  Query: {
    hello: () => 'Hello',
  },
  Mutation: {
    login: async (_, { email, password }, { res }) => {
      return await authController.login(email, password, res);
    },
    register: async (_, { email, password, name }) => {
      return await authController.register(email, password, name);
    },
  },
};
