import chai from 'chai';
const expect = chai.expect;
const request = require('supertest')('http://localhost:4040');
import { getAuth } from './__utils';

const queries = {
  rateLocation:
    'mutation { rateLocation (location: {name: "test location", coordinates: [25.345325423,-4.342543523]} ratings: [1,1,1,1,1]) { status message } }',
  locationRatings:
    'query { locationRatings(location: {name: "test location", coordinates: [25.345325423,-4.342543523]}) { mainAverage averagesCount averages }}',
};

describe('protocol rating endpoints', () => {
  var auth;
  before(() => {
    return new Promise((resolve) => {
      getAuth().then((res) => {
        auth = res;
        resolve();
      });
    });
  });
  it('fetches ratings for a non rated location', (done) => {
    request
      .post('/graphql')
      .set('Authorization', auth)
      .send({ query: queries.locationRatings })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.data.locationRatings.averages).to.eql([]);
        expect(res.body.data.locationRatings.averagesCount).to.equal(0);
        expect(res.body.data.locationRatings.mainAverage).to.equal(0);
        done();
      });
  });
  it('registers ratings for a certain location', (done) => {
    request
      .post('/graphql')
      .set('Authorization', auth)
      .send({ query: queries.rateLocation })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.data.rateLocation.status).to.be.true;
        done();
      });
  });
  it('fails when trying to rate the same location', (done) => {
    request
      .post('/graphql')
      .set('Authorization', auth)
      .send({ query: queries.rateLocation })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.data.rateLocation.message).to.equal(
          'Ya has valorado esta ubicación'
        );
        done();
      });
  });
  it('fetches ratings for an already rated location', (done) => {
    request
      .post('/graphql')
      .set('Authorization', auth)
      .send({ query: queries.locationRatings })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.data.locationRatings.averages).to.eql([1, 1, 1, 1, 1]);
        expect(res.body.data.locationRatings.averagesCount).to.equal(1);
        expect(res.body.data.locationRatings.mainAverage).to.equal(1);
        done();
      });
  });
});
