import { User } from '../models/User';
import bcrypt from 'bcrypt';
import * as config from '../.config.json';
import { JsonWebTokenError, sign, verify } from 'jsonwebtoken';
import { AuthenticationError } from 'apollo-server-errors';

const requireAuth = async (auth, f, params) => {
  if (!auth) throw new AuthenticationError('You must be logged in!');
  const token = auth.split('Bearer ')[1];
  if (!token) throw new AuthenticationError('You should provide a token!');
  const user = await verify(token, SECRET, (err, decoded) => {
    if (err) throw new AuthenticationError('Invalid token!');
    return decoded;
  });
  return await f(params, user);
};

const register = async (email, password, name) => {
  const user = await User.findOne({ email: email });
  if (user) {
    throw new Error('User already exists!');
  }
  const hashedPassword = await bcrypt.hash(password, 10);
  const newUser = new User({
    email,
    password: hashedPassword,
    name: name,
  });
  await newUser.save();
  return true;
};

const login = async (email, password, res) => {
  const user = await User.findOne({ email: email });
  if (!user) {
    throw new AuthenticationError('Username doesnt exist');
  }

  const valid = await bcrypt.compare(password, user.password);
  if (!valid) {
    throw new AuthenticationError('Wrong password');
  }
  const token = sign(
    {
      user,
    },
    config.SECRET,
    { expiresIn: '1d' }
  );

  return { user, token };
};

export const authController = {
  register,
  login,
  requireAuth,
};
