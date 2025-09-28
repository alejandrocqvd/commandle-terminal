export function authenticate(req, res, next) {
  const apiKey = req.headers["x-api-key"];
  const validKey = process.env.MY_GAME_API_KEY;

  if (!apiKey || apiKey !== validKey) {
    return res.status(403).json({ error: "Forbidden: invalid API key" });
  }
  next();
}
