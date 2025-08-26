{
  config,
  lib,
  vauxhall,
  ...
}:
let
  cfg' = config.nysa.Poseidon;
  cfg = cfg'.shells.programs.oh-my-posh;
in
{
  options.nysa.Poseidon.shells.programs.oh-my-posh.enable =
    lib.mkEnableOption "Poseidon's personal oh-my-posh config"
    // {
      default = cfg'.enable;
    };

  config = lib.mkIf cfg.enable {
    programs.oh-my-posh.settings = {
      blocks = [
        {
          newline = true;
          type = "prompt";
          alignment = "left";
          segments = [
            {
              type = "session";
              style = "accordion";
              leading_powerline_symbol = "";
              foreground = "black";
              background = "lightGreen";
              template = " {{ if .SSHSession }} {{ end }}{{ .HostName }} ";
            }
            {
              type = "session";
              style = "accordion";
              powerline_symbol = "";
              foreground = "black";
              background = "cyan";
              template = " {{ if .Root }}󱐋{{ end }}{{ .UserName }} ";
            }
            {
              type = "path";
              style = "accordion";
              powerline_symbol = "";
              foreground = "black";
              background = "lightBlue";
              properties.style = "agnoster_short";
            }
            {
              type = "git";
              style = "accordion";
              powerline_symbol = "";
              foreground = "black";
              background = "magenta";
              template = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} {{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }} ";
              properties = {
                branch_icon = " ";
                commit_icon = "@";
                fetch_status = true;
              };
            }
          ];
        }

        {
          type = "rprompt";
          alignment = "right";
          segments = [
            {
              type = "status";
              style = "accordion";
              leading_powerline_symbol = "";
              foreground = "black";
              background = "red";
              template = "󰀪 {{ .Code }}";
            }
            {
              type = "rust";
              style = "accordion";
              powerline_symbol = "";
              foreground = "black";
              background = vauxhall.orange.hex;
            }
            {
              type = "shell";
              style = "accordion";
              powerline_symbol = "";
              foreground = "black";
              background = vauxhall.yellow.hex;
              properties.mapped_shell_names = {
                fish = "󰈺 Fish";
              };
            }
            {
              type = "executiontime";
              style = "accordion";
              powerline_symbol = "";
              foreground = "black";
              background = "green";
              template = " 󱦟 {{ .FormattedMs }}";
              properties.threshold = 0;
            }
            {
              type = "nix-shell";
              style = "accordion";
              powerline_symbol = "";
              foreground = "black";
              background = "lightBlue";
              template = ''{{ if eq .Type "unknown" }}{{ else }} 󱄅 {{ .Type }}{{ end }}'';
            }
          ];
        }

        {
          type = "prompt";
          newline = true;
          alignment = "left";
          segments = [
            {
              type = "text";
              style = "plain";

              foreground_templates = [
                "{{ if gt .Code 0 }}red{{ end }}"
                "{{ if eq .Code 0 }}lightCyan{{ end }}"
              ];
              background = "transparent";
              template = "❯ ";
            }
          ];
        }
      ];

      transient_prompt = {
        foreground_templates = [
          "{{ if gt .Code 0 }}red{{ end }}"
          "{{ if eq .Code 0 }}lightCyan{{ end }}"
        ];
        background = "transparent";
        template = "❯ ";
      };
    };

  };
}
