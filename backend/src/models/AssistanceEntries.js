import mongoose, { mongo, Schema } from 'mongoose';
import { LocationModel } from '../models/Location';

const AssistanceEntrySchema = new mongoose.Schema({
  location: LocationModel.LocationSchema,
  user: String,
  createdAt: {
    type: Date,
    expires: 86400,
    default: Date.now,
  },
});

const AssistanceEntryModel = new mongoose.model(
  'AssistanceEntries',
  AssistanceEntrySchema,
  'AssistanceEntries'
);

export const AssistanceEntries = {
  AssistanceEntrySchema,
  AssistanceEntryModel,
};
