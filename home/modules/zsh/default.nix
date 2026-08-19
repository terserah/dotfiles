{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zsh-powerlevel10k
  ];

  programs.zsh = {
    enable = true;
    initContent = ''
      export TERM=xterm-256color
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh
      export PATH="$HOME/.local/bin:$PATH"
    '';
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      dotfile = "cd /data/dotfiles/";
      dot = "cd /data/dotfiles/";
      update = "sudo nixos-rebuild switch --flake /data/dotfiles#catnux";
      clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";    
    };

    setOptions = [
      "AUTO_CD"
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "dirhistory"
      ];
      # theme = "fino-time";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
  };
}
