import { ProtocolRatingModel } from '../models/ProtocolRating';

const rateLocation = async (params, user) => {
  const hasRated = await ProtocolRatingModel.ProtocolRating.find({
    user: user.user.email,
    geoLocation: {
      $near: {
        $geometry: {
          type: 'Point',
          coordinates: params.location.coordinates,
        },
        $maxDistance: 10,
      },
    },
  });
  if (hasRated[0]) {
    return { status: false, message: 'Ya has valorado esta ubicación' };
  }
  try {
    params.ratings.forEach(async (rating, index) => {
      const ratingEntry = new ProtocolRatingModel.ProtocolRating({
        geoLocation: {
          type: 'Point',
          coordinates: params.location.coordinates,
        },
        user: user.user.email,
        ratingId: index,
        value: rating,
      });
      await ratingEntry.save();
    });
    return { status: true, message: 'Valoración realizada correctamente' };
  } catch (mongoError) {
    return {
      status: false,
      message: 'No se ha podido establecer la conexión con la base de datos.',
    };
  }
};

const getLocationRatingsAverages = async (location, user) => {
  const averages = [];
  const averagesCount = await ProtocolRatingModel.ProtocolRating.distinct(
    'user',
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
    }
  ).exec();
  var averagesQuery = await ProtocolRatingModel.ProtocolRating.aggregate([
    {
      $geoNear: {
        distanceField: 'distance',
        spherical: true,
        near: location.coordinates,
        maxDistance: 0.00000156,
      },
    },
    {
      $group: { _id: { ratingId: '$ratingId' }, average: { $avg: '$value' } },
    },
    {
      $sort: { _id: 1 },
    },
  ]).exec();
  if (averagesQuery[0]) {
    averagesQuery.forEach((entry) => {
      averages.push(entry.average);
    });
  }
  return {
    mainAverage: averagesQuery[0]
      ? averages.reduce((a, b) => a + b) / averages.length
      : 0.0,
    averagesCount: averagesCount.length,
    averages,
  };
};

export const protocolRatingController = {
  rateLocation,
  getLocationRatingsAverages,
};
