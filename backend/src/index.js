import express from 'express';
import { ApolloServer } from 'apollo-server-express';
import { typeDefs } from './typeDefs';
import { resolvers } from './resolvers';
import mongoose from 'mongoose';
import * as config from './.config.json';

const startServer = async () => {
  const app = express();
  const server = new ApolloServer({
    typeDefs,
    resolvers,
    context: ({ req }) => {
      const auth = req.headers.authorization || '';
      return { auth };
    },
  });

  app.get('/', (req, res) => {
    res.redirect(301, '/graphql');
  });

  server.applyMiddleware({ app });

  await mongoose.connect(config.MONGOURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });

  await app.listen({ port: config.PORT }, () => {
    console.log(
      `🚀 Server ready at http://localhost:4040${server.graphqlPath}`
    );
  });
};

startServer();
