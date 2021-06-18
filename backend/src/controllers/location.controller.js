import { LocationModel } from '../models/Location';
import { AssistanceEntries } from '../models/AssistanceEntries';

const getLocation = async (latlng, user) => {
  const location = await LocationModel.Location.findOne({
    geoLocation: {
      $near: {
        $geometry: {
          type: 'Point',
          coordinates: latlng,
        },
        $maxDistance: 20,
      },
    },
  });
  if (!location) {
    throw new Error('Esta localización no ha sido registrada aún.');
  }
  const predictedAssistance = await AssistanceEntries.AssistanceEntryModel.countDocuments(
    {
      location: location,
    }
  );
  return { ...location.toObject(), predictedAssistance };
};

const addLocation = async (location, user) => {
  try {
    const newLocation = new LocationModel.Location({
      name: location.name,
      geoLocation: {
        type: 'Point',
        coordinates: location.coordinates,
      },
    });
    await newLocation.save();
    return { ...newLocation.toObject(), predictedAssistance: 0 };
  } catch (mongoError) {
    console.log(mongoError);
    throw new Error('Esta localización ya existe.');
  }
};

const noteForAssistance = async (location, user) => {
  try {
    const hasEntries = await AssistanceEntries.AssistanceEntryModel.find({
      "location.geoLocation": {
          $near: {
            $geometry: {
              type: 'Point',
              coordinates: location.coordinates,
            },
            $maxDistance: 20,
          },
      },
      user: user.email,
    });
    console.log(hasEntries);
    if (hasEntries[0] != null) {
      throw new Error("El usuario ya ha indicado su asistencia para esta localización.");
    }
    const location_ = await LocationModel.Location.findOne({
      geoLocation: {
        $near: {
          $geometry: {
            type: 'Point',
            coordinates: location.coordinates,
          },
          $maxDistance: 20,
        },
      },
    });
    const newAssistanceEntry = new AssistanceEntries.AssistanceEntryModel({
      user: user.email,
      location: location_,
    });
    await newAssistanceEntry.save();

    const predictedAssistance = await AssistanceEntries.AssistanceEntryModel.countDocuments(
      {
        location: location_,
      }
    );
    return { ...location_.toObject(), predictedAssistance };
  } catch (error) {
    throw new Error(error);
  }
};

export const locationController = {
  getLocation,
  addLocation,
  noteForAssistance,
};
