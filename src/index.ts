import type { Request, Response } from "express";
import express from "express";

const app = express();
const port = Number(process.env.PORT) || 3000;

app.get("/", (_req: Request, res: Response) => {
  res.send("Hello world");
});

const server = app.listen(port, () => {
  console.log(`Server is listening on http://localhost:${port}`);
});

process.on("SIGTERM", () => {
  console.log("Received SIGTERM, shutting down gracefully.");
  server.close(() => {
    console.log("HTTP server closed.");
    process.exit(0);
  });

  setTimeout(() => {
    console.error("Forcefully shutting down.");
    process.exit(1);
  }, 10000);
});
