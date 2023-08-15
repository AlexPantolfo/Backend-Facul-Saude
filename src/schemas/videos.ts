import { VideoModel } from '../models/videoModel';
import mongoose from "mongoose";

const VideoSchema = new mongoose.Schema({
    link: {
        type: String,
        require: true,
        unique: true,
        upsert: true
    },
    titulo: {
        type: String,
        require: true
    },
    descricao: {
        type: String,
    }
});


export default mongoose.model<VideoModel>('Videos', VideoSchema);