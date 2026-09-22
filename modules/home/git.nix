{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Rezky Yuranda";
      user.email = "yurandarezky@atmaluhur.ac.id";

      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}