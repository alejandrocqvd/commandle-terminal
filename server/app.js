import express from "express";
import sessionsRouter from "./routes/sessions.js";
import { authenticate } from "./middleware/auth.js";
import dotenv from "dotenv";

dotenv.config();
const app = express();
const PORT = process.env.PORT || 5000;

app.use(express.json());

// Health check (no auth, so you can test if container is alive)
app.get("/", (req, res) => {
  res.send("Game server API running ✅");
});

// Protect everything below with API key middleware
app.use(authenticate);

// Use session routes
app.use("/", sessionsRouter);

app.listen(PORT, () => {
  console.log(`Game server API listening on port ${PORT}`);
});
