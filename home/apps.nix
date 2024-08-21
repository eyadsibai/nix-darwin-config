{ pkgs
, nixvim
, username
, ...
}:

{
  programs.helix.enable = true;
  programs.helix = {
    #    language = [{
    #   name = "rust";
    #   auto-format = false;
    # }];
    settings = {
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        bufferline = "always";
        text-width = 79;
        rulers = [ 80 ];
        auto-save = true;
        whitespace.render = {
          newline = "all";
          space = "none";
          nbsp = "all";
          tab = "none";
        };

        indent-guides.render = true;
      };
    };
  };
  programs.yt-dlp.enable = true;
  programs.kakoune.enable = true;
  programs.btop.enable = true;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.jq.enable = true;

}
