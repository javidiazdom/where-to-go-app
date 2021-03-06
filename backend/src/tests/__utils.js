import mongoose from 'mongoose';
import express from 'express';
import { ApolloServer } from 'apollo-server-express';
import 'core-js/stable';
import 'regenerator-runtime/runtime';
import { typeDefs } from '../typeDefs';
import { resolvers } from '../resolvers';
import { async } from 'regenerator-runtime/runtime';
const request = require('supertest')('http://localhost:4040');

export const startServer = async () => {
  const server = new ApolloServer({
    typeDefs,
    resolvers,
    context: ({ req }) => {
      const auth = req.headers.authorization || '';
      return { auth };
    },
  });
  const app = express();

  server.applyMiddleware({ app });

  await mongoose.connect('mongodb://localhost:27017/test', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });

  const serverExec = await app.listen({ port: 4040 }, () => {});

  return serverExec;
};

export const dropCollections = async () => {
  const collections = await mongoose.connection.db.collections();

  for (let collection of collections) {
    await collection.drop();
  }
};

export const getAuth = async () => {
  const login = await request.post('/graphql').send({
    query:
      'mutation { login (email: "test1@gmail.com", password: "1234") { token } }',
  });
  return `Bearer ${login.body.data.login.token}`;
};
