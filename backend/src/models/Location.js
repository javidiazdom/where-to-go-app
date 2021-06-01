import mongoose, { mongo, Schema } from 'mongoose';

const pointSchema = new mongoose.Schema({
  type: {
    type: String,
    enum: ['Point'],
    required: true,
  },
  coordinates: {
    type: [Number],
    required: true,
  },
});

const LocationSchema = new Schema({
  name: String,
  predictedAssistance: Number,
  geoLocation: {
    type: pointSchema,
  },
});

LocationSchema.index({ geoLocation: '2dsphere' }, { background: false });

const Location = mongoose.model('Location', LocationSchema, 'Location');

Location.createIndexes().catch((e) => console.error(e));

export const LocationModel = {
  pointSchema,
  Location,
  LocationSchema,
};
