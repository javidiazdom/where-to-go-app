import chai from 'chai';
const expect = chai.expect;
const request = require('supertest')('http://localhost:4040');
import { getAuth } from './__utils';

const queries = {
  addLocationQuery:
    'mutation { addLocation (location: {name: "test location", coordinates: [25.345325423,-4.342543523] } ) { name } }',
  getLocationQuery:
    'query {location (latlng:[25.345325423,-4.342543523]) {name}}',
  getNonExistingLocationQuery:
    'query {location (latlng:[21.3432325423,12.342543523]) {name}}',
  noteForAssistance:
    'mutation { noteForAssistance(location: {name:"test location", coordinates: [25.345325423,-4.342543523]}) { predictedAssistance}}',
};

describe('location endpoints', () => {
  var auth;
  before(() => {
    return new Promise((resolve) => {
      getAuth().then((res) => {
        auth = res;
        resolve();
      });
    });
  });
  it('adds locations', (done) => {
    request
      .post('/graphql')
      .set('Authorization', auth)
      .send({ query: queries.addLocationQuery })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.data.addLocation.name).to.equal('test location');
        done();
      });
  });
  it('fails when not setting authentication headers', (done) => {
    request
      .post('/graphql')
      .send({ query: queries.addLocationQuery })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.errors[0].message).to.equal('You must be logged in!');
        done();
      });
  });
  it('fetches locations by lattitude and longitude', (done) => {
    request
      .post('/graphql')
      .set('Authorization', auth)
      .send({ query: queries.getLocationQuery })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.data.location.name).to.equal('test location');
        done();
      });
  });
  it('fails fetching non registered locations', (done) => {
    request
      .post('/graphql')
      .set('Authorization', auth)
      .send({ query: queries.getNonExistingLocationQuery })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.errors[0].message).to.equal(
          'Esta localización no ha sido registrada aún.'
        );
        done();
      });
  });

  it('registers assistance for an existing location', (done) => {
    request
      .post('/graphql')
      .set('Authorization', auth)
      .send({ query: queries.noteForAssistance })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.data.noteForAssistance.predictedAssistance).to.equal(1);
        done();
      });
  });
});
