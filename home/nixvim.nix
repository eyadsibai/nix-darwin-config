{inputs, ...}: {
  programs.nixvim = {
    enable = true;

    # colorschemes.gruvbox.enable = true;

    plugins = {
      lightline.enable = true;
      nvim-tree.enable = true;

      gitsigns.enable = true;

      fugitive.enable = true;

      diffview.enable = true;

      neogit.enable = true;
    };
  };
}
