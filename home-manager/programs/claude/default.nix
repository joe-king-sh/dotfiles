_:

{
  # Claude Code is installed via the official native installer:
  #   curl -fsSL https://claude.ai/install.sh | bash
  # Binary lives at ~/.local/bin/claude (PATH set in programs/zsh/default.nix)
  # and auto-updates in the background.

  # Claude Code settings (global)
  home.file.".config/claude/settings.json".text = builtins.toJSON {
    env = {
      CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1";
    };
    acceptedAutoMode = true;
    permissions = {
      allow = [
        "Bash(git -C ~/personal/myrepo/brain:*)"
      ];
      hooks = {
        PreToolUse = [
          {
            matcher = "AskUserQuestion";
            hooks = [
              {
                type = "command";
                command = "terminal-notifier -title 'Claude Code' -message '質問させてください' -sound Frog";
              }
            ];
          }
        ];
        Notification = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "terminal-notifier -title 'Claude Code' -message 'ちょっと困ってます' -sound Frog";
              }
            ];
          }
        ];
        Stop = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "terminal-notifier -title 'Claude Code' -message '終わりました！' -sound Glass";
              }
            ];
          }
        ];
        SessionEnd = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "bash ~/.config/claude/save-session-log.sh";
                timeout = 10;
              }
            ];
          }
        ];
      };
    };
    enabledPlugins = {
      "decomposition@kuu-marketplace" = true;
      "dig@kuu-marketplace" = true;
    };
    effortLevel = "high";
    includeCoAuthoredBy = false;
    teammateMode = "tmux";
    # MCP servers are managed via `claude mcp add --scope user` (stored in .claude.json)
    # Do NOT put mcpServers here - settings.json is not read for MCP config
    voiceEnabled = true;
    statusLine = {
      type = "command";
      command = "cat | bash ~/.config/claude/statusline.sh";
    };
  };

  # Global CLAUDE.md (overrides MCP-injected instructions)
  home.file.".config/claude/CLAUDE.md".text = ''
    # Global Instructions

    ## Commit Messages
    - Follow the commit message format specified in each project's CLAUDE.md.
  '';

  # Statusline script
  home.file.".config/claude/statusline.sh" = {
    source = ./statusline.sh;
    executable = true;
  };

  # Session log save script
  home.file.".config/claude/save-session-log.sh" = {
    source = ./save-session-log.sh;
    executable = true;
  };

  # Also set in shell environment
  programs.zsh.sessionVariables = {
    CLAUDE_CONFIG_DIR = "$HOME/.config/claude";
  };
}
