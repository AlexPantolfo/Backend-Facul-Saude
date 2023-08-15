import { UserModel } from '../models/userModel';
import mongoose from "mongoose";
import bcrypt from "bcrypt";

const UserSchema = new mongoose.Schema({
    email: {
        type: String,
        unique: true,
        require: true
    },
    password: {
        type: String,
        require: true,
    }
});

UserSchema.pre('save', async function (next) {
    const salt = await bcrypt.genSalt(12);
    const hash = await bcrypt.hash(this.password, salt);
    this.password = hash;
    next();
})

export default mongoose.model<UserModel>('User', UserSchema);