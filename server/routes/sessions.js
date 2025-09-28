import { Router } from "express";
import { exec } from "child_process";

const router = Router();

/**
 * Creates a new session for the given user ID.
 * Expects JSON body: { "userId": "some-user-id" }
 */
router.post("/start-session", (req, res) => {
  const { userId } = req.body;

  exec(`/usr/local/bin/start-session.sh ${userId}`, (err, stdout, stderr) => {
    if (err)
        return res.status(500).json({ error: stderr });

    res.json({ output: stdout });
  });
});

/**
 * Stops the session for the given user ID.
 * Expects JSON body: { "userId": "some-user-id" }
 */
router.post("/stop-session", (req, res) => {
  const { userId } = req.body;

  exec(`/usr/local/bin/stop-session.sh ${userId}`, (err, stdout, stderr) => {
    if (err) 
        return res.status(500).json({ error: stderr });
    
    res.json({ output: stdout });
  });
});

/**
 * Lists all active sessions.
 * No parameters required.
 */
router.get("/list-sessions", (req, res) => {
  exec(`/usr/local/bin/list-sessions.sh`, (err, stdout, stderr) => {
    if (err) 
        return res.status(500).json({ error: stderr });

    res.json({ output: stdout });
  });
});

export default router;
