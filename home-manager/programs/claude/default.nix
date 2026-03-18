_:

{
  # Claude Code is installed via Homebrew (nix-darwin/default.nix)

  # Claude Code settings (global)
  home.file.".config/claude/settings.json".text = builtins.toJSON {
    env = {
      CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1";
    };
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
      };
    };
    enabledPlugins = {
      "decomposition@kuu-marketplace" = true;
      "dig@kuu-marketplace" = true;
    };
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
    - Do NOT add "Co-Authored-By: Happy" or any Happy-related trailers to commit messages.
    - Do NOT add "Generated with Claude Code via Happy" or similar attribution to commit messages.
    - Follow the commit message format specified in each project's CLAUDE.md.
  '';

  # Statusline script
  home.file.".config/claude/statusline.sh" = {
    source = ./statusline.sh;
    executable = true;
  };

  # Also set in shell environment
  programs.zsh.sessionVariables = {
    CLAUDE_CONFIG_DIR = "$HOME/.config/claude";
  };
}
