import mongoose, { mongo, Schema } from "mongoose";

const LocationSchema = new Schema({
    name: String,
    predictedAssistance: Number,
    coordinates: {
        lattitude: Number, 
        longitude: Number
    },
});

const Location = mongoose.model("Location", LocationSchema, "Location");

export const LocationModel = {
    Location,
    LocationSchema
}