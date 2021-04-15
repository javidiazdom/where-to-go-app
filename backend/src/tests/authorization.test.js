import chai from 'chai';
import { disconnect } from 'mongoose';
const expect = chai.expect;
const request = require('supertest')('http://localhost:4040');

it('register users', (done) => {
  request
    .post('/graphql')
    .send({
      query:
        'mutation { register (email: "test1@gmail.com", password: "1234") }',
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
        'mutation { register (email: "test1@gmail.com", password: "1234") }',
    })
    .expect(200)
    .end((err, res) => {
      if (err) return done(err);
      expect(res.body.errors[0].message).to.equal('User already exists!');
      done();
    });
});
