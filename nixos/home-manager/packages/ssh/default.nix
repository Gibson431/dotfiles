{...}: {
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = "IdentityAgent ~/.1password/agent.sock";
  };
}
