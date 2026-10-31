# Deploy and Host NOFX on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/nofx-trading?referralCode=sLjDXb&utm_medium=integration&utm_source=button&utm_campaign=nofx-trading)

[NOFX](https://github.com/NoFxAiOS/nofx) is an open-source AI trading system you run yourself. You connect an exchange and an AI model, pick or write a strategy, and LLM "traders" (DeepSeek, Qwen, Claude, GPT, Gemini, Grok, Kimi and others) read the market and place trades on Binance, Bybit, OKX, Bitget, Hyperliquid, Aster and more, with a web dashboard for positions, decisions and performance. This template runs it as one service with its data on a volume and your account claimed on first boot.

## About Hosting NOFX

One service: the NOFX backend and its web UI behind one domain, with SQLite on a volume at `/app/data`.

NOFX is a single-user system: whoever registers first owns it, and every exchange and AI key saved after that. On a public domain that could be a stranger. This template creates your account from `NOFX_ADMIN_EMAIL` and `NOFX_ADMIN_PASSWORD` before the domain starts answering, so registration is closed by the time anyone can reach it.

It also fixes two things that bite a plain deploy: the encryption keys that protect your saved exchange and AI keys stay the same across restarts (`DATA_ENCRYPTION_KEY` as a variable, the RSA key kept on the volume), and the healthcheck asks the backend itself, so Railway restarts NOFX if the trading engine dies instead of reporting it healthy.

## Common Use Cases

- Running AI trading agents on crypto perpetuals around the clock, without leaving a laptop on
- Comparing LLMs on the same strategy side by side (DeepSeek vs Qwen vs Claude) on paper-sized accounts
- Writing and backtesting your own strategy prompts and indicators in the strategy studio
- Trading on Hyperliquid or Aster with an agent wallet instead of handing over a withdrawal-enabled key

## Dependencies for NOFX Hosting

- An exchange account and API key (trade permission only; never enable withdrawals)
- An AI model API key (DeepSeek, OpenAI, Anthropic, Qwen and others), or a Claw402 wallet

### Deployment Dependencies

- [NOFX on GitHub](https://github.com/NoFxAiOS/nofx)
- [Template source on GitHub](https://github.com/two-workspaces/nofx)

### Implementation Details

**First use:**

1. Open the NOFX service's domain once it's green and click **Sign in**.
2. Log in with `NOFX_ADMIN_EMAIL` (by default `admin@` your Railway domain) and `NOFX_ADMIN_PASSWORD` from the Variables tab.
3. Under **Config**, add an AI model and an exchange with their API keys.
4. Create a trader, pick a strategy, and start it with a small balance first.

**Your keys:** the browser encrypts API keys before sending them (`TRANSPORT_ENCRYPTION`), and NOFX stores them encrypted with `DATA_ENCRYPTION_KEY`. Keep that variable unchanged: a new value makes every saved key unreadable. A volume backup alone can't decrypt them without it.

**Custom domain:** add it to `CORS_ALLOWED_ORIGINS` (comma-separated) next to the Railway domain.

Notes and limits:

- The admin variables only matter on first boot. Changing them later does nothing; NOFX has no password reset over the web, by design.
- About 60 MB of RAM idle; each running trader adds a little plus its AI calls.
- Some exchanges block or restrict API access from cloud and US IP addresses. Check your exchange's rules before trading from Railway.
- Usage stats to the NOFX team are off (`EXPERIENCE_IMPROVEMENT=false`); set it to `true` to opt in.
- NOFX has no tagged releases, so this template pins one upstream build. Back up the volume before updating.
- Trading with AI agents can lose money quickly. NOFX is experimental software; you are responsible for your trades.

## Why Deploy NOFX on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying NOFX on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
