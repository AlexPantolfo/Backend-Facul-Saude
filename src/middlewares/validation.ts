import mongoose from 'mongoose';
import { BadRequestError } from '../lib/errors';
import jwt from "jsonwebtoken";

export const validateObjectId = (req, res, next) => {
  if (!mongoose.Types.ObjectId.isValid(req.params.id)) {
    throw new BadRequestError('ID invalido');
  }
  next();
};

export const checkToken = (req, res, next) => {
  const token = req.headers['authorization'];

  if (!token) return res.status(401).json({ msg: "Acesso negado!" }).end();

  try {
    const secret = process.env.SECRET;

    jwt.verify(token, secret);

    next();
  } catch (err) {
    res.status(400).json({ msg: "O Token é inválido!" }).end();
  }
}

