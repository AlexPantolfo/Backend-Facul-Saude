import type { ErrorRequestHandler } from "express";

const errorHandler: ErrorRequestHandler = (error, req, res, next) => {
  res.status(error.status || 500).json({
    message: error.message || 'Erro inesperado do servidor',
  });
};

export default errorHandler;
