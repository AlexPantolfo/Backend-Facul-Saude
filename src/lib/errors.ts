export class NotFoundError extends Error {
  status: number;
  constructor(message) {
    super(message);
    this.status = 404;
  }
}

export class BadRequestError extends Error {
  status: number;
  constructor(message) {
    super(message);
    this.status = 400;
  }
}