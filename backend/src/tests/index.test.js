import mongoose from 'mongoose';
import { startServer, dropCollections } from './__utils';

describe('Where to go API', () => {
  var server;
  before((done) => {
    startServer().then((res) => {
      server = res;
      done();
    });
  });

  after((done) => {
    mongoose.connection.close().then(() => {
      dropCollections();
      server.close(done);
    });
  });

  describe('authorization endpoints', () => {
    require('./authorization.test');
  });
});
