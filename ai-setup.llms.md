# AI that helps you learn

Four levels of AI help for R, from chat to an agent inside RStudio, with setup steps and ground rules.

The syllabus allows “any resources” in the lab exam. Check the exact AI rules with the TAs. AI makes you faster, but **you** are graded: the code has to be right, and the interpretation has to be yours.

## Ground rules (every level)

1.  **Give context:** the task, the variable codes (paste the output of `table()`), your code, and the full error.
2.  **Run it line by line,** and check every step with `table()`, `summary()` and `nobs()`.
3.  **If you can’t explain a line, don’t hand it in.** Ask the AI to explain it until you can.
4.  **Write the interpretations yourself.** AI prose looks the same for everyone who uses it.
5.  **Agents:** open only your project folder, and read every change before you accept it.

## Level 1 · Chat (everyone)

Any chat assistant you already use (ChatGPT, Claude, Gemini, …) in the browser or the app. You copy and paste between the chat and RStudio.

## Level 2 · A desktop agent in your project folder

The desktop apps can work **on a folder on your computer**: they read your script and data, write code, and run R for you. Point them at your `labexam` project folder, nothing else.

| App | How | Plans |
|----|----|----|
| **ChatGPT desktop app** (Codex) | Install, sign in, then “open a folder” and choose `labexam` ([OpenAI docs](https://learn.chatgpt.com/codex/app)) | Codex is included in the ChatGPT plans, Plus and up; for Free and Go, check what your plan allows ([pricing](https://learn.chatgpt.com/docs/pricing)) |
| **Claude desktop app**, Code tab (Claude Code) | Code tab → project folder control → choose `labexam` ([Anthropic docs](https://code.claude.com/docs/en/desktop)) | A paid Claude plan |

Ask it, for example: “Read my script `Lastname_Firstname_labexam.R` and the task. Run section 3 and explain any error.” Keep RStudio open next to it, and run the code there yourself too.

## Level 3 · Inside RStudio: Posit Assistant with Codex

Posit Assistant is the AI sidebar in RStudio 2026.04 and later. Its **Agent engines** (a Preview feature) can run Codex using your **ChatGPT sign-in**, so you don’t need a paid API key. This is a one-time setup of about 10 minutes, and it needs a terminal. Do it **before** the exam.

## Mac (tested)

1.  Update RStudio if needed (*Help \> Check for Updates*), then click the Posit Assistant icon at the top right → **Install Posit Assistant**.

2.  Open RStudio’s **Terminal** tab (next to the Console) and install the Codex command-line tool:

    ``` bash
    curl -fsSL https://chatgpt.com/codex/install.sh | sh
    ```

3.  Sign in with ChatGPT **into Posit’s engine folder**. This exact line matters; a plain `codex login` doesn’t reach RStudio:

    ``` bash
    CODEX_HOME="$HOME/.posit/assistant/engines/codex-agent" codex login
    ```

    If you get `codex: command not found`, open a new terminal tab and try again. A browser window opens: sign in with your ChatGPT account.

4.  In the Posit Assistant sidebar: **More actions** (⋯) → **Configure AI providers** → **Agent engines** → **Codex Agent** → **Connect**.

5.  Restart RStudio and start a new conversation with the Codex Agent.

## Windows (untested)

Nobody has tested this yet. If you try it, say whether it works so this page can be fixed.

1.  Same as on a Mac: update RStudio, then **Install Posit Assistant**.

2.  In a **new PowerShell window**, install Codex:

    ``` powershell
    powershell -ExecutionPolicy ByPass -c "irm https://chatgpt.com/codex/install.ps1 | iex"
    ```

3.  In a new PowerShell window, sign in into Posit’s engine folder:

    ``` powershell
    $env:CODEX_HOME = "$HOME/.posit/assistant/engines/codex-agent"
    codex login
    ```

4.  In the Posit Assistant sidebar: **More actions** → **Configure AI providers** → **Agent engines** → **Codex Agent** → **Connect**, then restart RStudio.

Sources: [Posit Assistant agent engines](https://assistant.posit.co/docs/getting-started/agent-engines/), [Codex CLI install](https://learn.chatgpt.com/docs/codex/cli).

> **NOTE:**
>
> - **Claude Pro/Max** doesn’t work inside Posit Assistant: its Claude Agent needs a paid Anthropic API key. Use the Claude desktop app (Level 2) instead.
> - **GitHub Copilot** in RStudio (*Tools \> Global Options \> Assistant*) gives code completions as grey “ghost text”, but no chat.
> - **API keys** (OpenAI, Anthropic) work everywhere, but you pay per use on top of any subscription.

## Level 4 · No terminal: Posit AI Pass

If you have no ChatGPT account or don’t want a terminal: Posit Assistant with **Posit AI Pass**. Sign in from the sidebar, with no installs beyond RStudio. It costs \$5 for the first month, then \$20/month, with no free trial and no student discount ([Posit](https://posit.co/products/ai)). Cancel it after the exam if you don’t need it.

Back to top
