import mongoose from "mongoose";
import { LocationModel } from "./Location";
import { ProtocolRatingModel } from "./ProtocolRating";

export const User = mongoose.model(
  "User",
  {
    name: String,
    email: String,
    password: String,
    locationHistory: [
      {
        location: LocationModel.LocationSchema,
        date: Number,
      },
    ],
    ratingHistory: [ProtocolRatingModel.ProtocolRatingSchema],
  },
  "User"
);
