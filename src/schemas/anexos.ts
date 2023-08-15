import { AnexosModel } from '../models/anexosModel';
import mongoose from "mongoose";

const AnexosSchema = new mongoose.Schema({
    anexo: {
        type: String,
        contentType: String,
        require: true,
        unique: true,
        upsert: true
    },
    titulo: {
        type: String,
        require: true,
        upsert: true
    },
    descricao: {
        type: String,
    }
});


export default mongoose.model<AnexosModel>('Anexos', AnexosSchema);