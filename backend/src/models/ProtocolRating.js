import mongoose, { mongo, Schema } from "mongoose";

const ProtocolRatingSchema = new Schema({
    locationId: String,
    user: String,
    ratings: [Number]
});

const ProtocolRating = mongoose.model("ProtocolRating", ProtocolRatingSchema , "ProtocolRating")

export const ProtocolRatingModel = {
    ProtocolRating, 
    ProtocolRatingSchema
}