import chai from 'chai';
const expect = chai.expect;
const request = require('supertest')('http://localhost:4040');
import { getAuth } from './__utils';

const queries = {
  getLocationQuery:
    'query {location (latlng:[25.345325423,-4.342543523]) {name}}',
};

describe('authorization endpoints', () => {
  it('register users', (done) => {
    request
      .post('/graphql')
      .send({
        query:
          'mutation { register (email: "test1@gmail.com", password: "1234", name: "Nombre de Prueba") }',
      })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        done();
      });
  });

  it('fails when registering existing user', (done) => {
    request
      .post('/graphql')
      .send({
        query:
          'mutation { register (email: "test1@gmail.com", password: "1234" ,name: "Nombre de Prueba") }',
      })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.errors[0].message).to.equal('User already exists!');
        done();
      });
  });

  it('logs in users and returns jwt token', (done) => {
    request
      .post('/graphql')
      .send({
        query:
          'mutation { login (email: "test1@gmail.com", password: "1234") { token } }',
      })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        done();
      });
  });

  it('throws error when any of the login credentials are wrong', (done) => {
    request
      .post('/graphql')
      .send({
        query:
          'mutation { login (email: "test1@gmail.com", password: "1256") { token } }',
      })
      .expect(200)
      .end((err, res) => {
        expect(res.body.errors[0].message).to.equal('Wrong password');
        done();
      });
  });
});

describe('authentication service', () => {
  var auth;
  before(() => {
    return new Promise((resolve) => {
      getAuth().then((res) => {
        auth = res;
        resolve();
      });
    });
  });
  it('fails when not authenticated', (done) => {
    request
      .post('/graphql')
      .send({ query: queries.getLocationQuery })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.errors[0].message).to.equal('You must be logged in!');
        done();
      });
  });
  it('fails when auth token is not formated correctly', (done) => {
    request
      .post('/graphql')
      .set('Authorization', "Wrong Format")
      .send({ query: queries.getLocationQuery })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.errors[0].message).to.equal('You should provide a token!');
        done();
      });
  });
  it('fails when auth token is wrong', (done) => {
    request
      .post('/graphql')
      .set('Authorization', "Bearer SomeRandomTextAndNumbers123456")
      .send({ query: queries.getLocationQuery })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.errors[0].message).to.equal('Invalid token!');
        done();
      });
  });
  it('works propperly when token is set correctly', (done) => {
    request
      .post('/graphql')
      .set('Authorization', auth)
      .send({ query: queries.getLocationQuery })
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        expect(res.body.errors[0].message).to.equal(
          'Esta localización no ha sido registrada aún.'
        );
        done();
      });
  });
});
