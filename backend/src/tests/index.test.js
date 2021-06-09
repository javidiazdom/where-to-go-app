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

  after(() => {
    return new Promise((resolve) => {
      dropCollections().then(() => {
        mongoose.connection.close().then(() => {
          server.close(resolve);
        });
      });
    });
  });

  describe('http tests', () => {
    require('./authorization.test');
    require('./location.test');
    require('./protocolRatings.test');
  });
});
