import mongoose, { mongo, Schema } from 'mongoose';
import { LocationModel } from './Location';

const ProtocolRatingSchema = new Schema({
  geoLocation: LocationModel.pointSchema,
  user: String,
  ratingId: Number,
  value: Number,
});

ProtocolRatingSchema.index({ geoLocation: '2dsphere' }, { background: false });

const ProtocolRating = mongoose.model(
  'ProtocolRating',
  ProtocolRatingSchema,
  'ProtocolRating'
);

ProtocolRating.createIndexes().catch((e) => console.error(e));

export const ProtocolRatingModel = {
  ProtocolRating,
  ProtocolRatingSchema,
};
