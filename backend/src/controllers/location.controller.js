import { LocationModel } from '../models/Location';

const getLocation = async (latlng, user) => {
  const location = await LocationModel.Location.findOne({
    coordinates: latlng,
  });
  if (!location) {
    throw new Error('This location has not yet been registered');
  }
  return location;
};

export const locationController = {
  getLocation,
};
