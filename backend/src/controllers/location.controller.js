import { LocationModel } from '../models/Location';

const getLocation = async (latlng, user) => {
  const location = await LocationModel.Location.findOne({
    geoLocation: {
      $near: {
        $geometry: {
          type: 'Point',
          coordinates: latlng,
        },
        $maxDistance: 10,
      },
    },
  });
  if (!location) {
    throw new Error('Esta localización no ha sido registrada aún.');
  }
  return location;
};

const addLocation = async (location, user) => {
  try {
    const newLocation = new LocationModel.Location({
      name: location.name,
      predictedAssistance: 0,
      geoLocation: {
        type: 'Point',
        coordinates: location.coordinates,
      },
    });
    await newLocation.save();
    return newLocation;
  } catch (mongoError) {
    console.log(mongoError);
    throw new Error('Esta localización ya existe.');
  }
};

const noteForAssistance = async (location, user) => {
  try {
    const location_ = await LocationModel.Location.findOneAndUpdate(
      {
        geoLocation: {
          $near: {
            $geometry: {
              type: 'Point',
              coordinates: location.coordinates,
            },
            $maxDistance: 10,
          },
        },
      },
      { $inc: { predictedAssistance: 1 } },
      { new: true }
    );
    return location_;
  } catch (mongoError) {
    throw new Error(mongoError);
  }
};

export const locationController = {
  getLocation,
  addLocation,
  noteForAssistance,
};
