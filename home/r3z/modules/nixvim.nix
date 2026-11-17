{ config, pkgs, ... }:
let
  # "flat" = background gelap tanpa border; "rounded" = sudut rounded + border tipis.
  codeBoxStyle = "flat";

  # Ukuran font code block di PDF (pt), line-height otomatis +2.
  codeFontSize = 9;

  # Ukuran font inline code (`...`) di PDF, sedikit lebih kecil dari body.
  inlineCodeFontSize = 10;

  # Warna background inline code (`...`) di PDF (HTML hex tanpa #); null = tanpa background.
  inlineCodeBackground = "E6E8F0";

  # Nomor baris di code block.
  codeLineNumbers = true;

  # Baris kode panjang dipatahkan otomatis di PDF.
  codeWrapLongLines = true;

  codeLineNumberOptions =
    if codeLineNumbers then "numbers=left,numbersep=8pt" else "numbers=none";

  codeWrapOptions =
    if codeWrapLongLines then
      ",breaklines,breakanywhere,breaknonspaceingroup,breakanywheresymbolpre={}"
    else
      "";

  # Gambar tetap di urutan teks; kalau tidak cukup, pindah ke halaman berikutnya.
  keepImagesInOrder = true;

  imagePlacement =
    if keepImagesInOrder then
      ''
        \usepackage{float}
        \floatplacement{figure}{H}
      ''
    else
      "";

  # Header LaTeX untuk background inline code (`...`).
  inlineCodePreamble =
    if inlineCodeBackground == null then
      ""
    else
      ''
        \usepackage{luacolor}
        \usepackage{lua-ul}
        \definecolor{InlineCodeBg}{HTML}{${inlineCodeBackground}}
      '';

  inlineCodeCommand =
    if inlineCodeBackground == null then
      ''
        \renewcommand{\texttt}[1]{{\fontsize{${toString inlineCodeFontSize}}{${toString (inlineCodeFontSize + 2)}}\selectfont\ttfamily #1}}
      ''
    else
      ''
        \renewcommand{\texttt}[1]{{\fontsize{${toString inlineCodeFontSize}}{${toString (inlineCodeFontSize + 2)}}\selectfont\ttfamily\hyphenchar\font=-1 \highLight[InlineCodeBg]{#1}}}
      '';

  # Filter Pandoc: beri titik putus tak terlihat di inline code yang panjang,
  # supaya token panjang tidak keluar margin PDF.
  breakableInlineCodeFilter = pkgs.writeText "breakable-inline-code.lua" ''
    local SENTINEL = '\u{E000}'
    local CHUNK = 16

    local function escape_code(text)
      local doc = pandoc.Pandoc({ pandoc.Plain({ pandoc.Code(text) }) })
      local tex = pandoc.write(doc, 'latex')
      return tex:match('^\\texttt{(.*)}%s*$')
    end

    local function add_breaks(text)
      return (text:gsub('%S+', function(run)
        if #run <= CHUNK then
          return run
        end
        local out = {}
        local n = 0
        for ch in run:gmatch(utf8.charpattern) do
          out[#out + 1] = ch
          n = n + 1
          if n % CHUNK == 0 then
            out[#out + 1] = SENTINEL
          end
        end
        return table.concat(out)
      end))
    end

    function Code(el)
      if not el.text:find('%S') then
        return nil
      end
      local body = escape_code(add_breaks(el.text))
      if not body then
        return nil
      end
      body = body:gsub(SENTINEL, '\\allowbreak{}')
      return pandoc.RawInline('latex', '\\texttt{' .. body .. '}')
    end
  '';

  codeBoxLeftPadding = if codeLineNumbers then "20pt" else "6pt";

  codeBoxOptions =
    if codeBoxStyle == "rounded" then
      ''
        colback=CodeBg,
        colframe=gray!45,
        boxrule=0.4pt,
        arc=3pt,
      ''
    else
      ''
        colback=CodeBg,
        colframe=CodeBg,
        boxrule=0pt,
        arc=0pt,
      '';
in
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # Pakai pkgs dari Home Manager supaya tidak ada instance nixpkgs kedua.
    nixpkgs.useGlobalPackages = true;

    globals = {
      mapleader = ";";
      maplocalleader = "\\";
    };

    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      expandtab = true;
      smartindent = true;

      termguicolors = true;
      signcolumn = "yes";
      cursorline = true;

      ignorecase = true;
      smartcase = true;
      incsearch = true;
      hlsearch = true;

      splitright = true;
      splitbelow = true;
      scrolloff = 8;
      wrap = false;

      updatetime = 250;
      timeoutlen = 300;

      clipboard = "unnamedplus";
      mouse = "a";
      undofile = true;
      swapfile = false;
    };

    # Markdown enak dibaca kalau di-wrap; jangan aktifkan spell karena teks Indonesia.
    autoCmd = [
      {
        event = "FileType";
        pattern = "markdown";
        command = "setlocal wrap linebreak";
        desc = "Wrap Markdown text";
      }
    ];

    colorschemes.tokyonight = {
      enable = true;
      settings = {
        transparent = true;
        styles = {
          sidebars = "transparent";
          floats = "transparent";
        };
      };
    };
    colorscheme = "tokyonight";

    plugins = {
      lualine.enable = true;
      gitsigns.enable = true;
      which-key.enable = true;
      telescope = {
        enable = true;
        extensions.file-browser = {
          enable = true;
          settings = {
            hijack_netrw = true;
            hidden = true;
            respect_gitignore = true;
          };
        };
      };

      toggleterm = {
        enable = true;
        settings = {
          direction = "float";
          size = 20;
          open_mapping = "[[<c-\\>]]";
          start_in_insert = true;
          shade_terminals = false;
          persist_size = true;
          persist_mode = true;
          float_opts = {
            border = "curved";
            width = 120;
            height = 30;
            winblend = 0;
          };
        };
      };

      lazygit.enable = true;

      # Paste gambar dari clipboard langsung jadi file di ./assets + embed markdown.
      img-clip = {
        enable = true;
        settings.default = {
          dir_path = "assets";
          relative_to_current_file = true;
          prompt_for_file_name = false;
          copy_images = true;
        };
      };

      # Render heading, list, tabel, code block, dsb. langsung di buffer.
      render-markdown.enable = true;

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;

        # Parser dipasang lewat Nix (reproducible, tanpa compile saat runtime).
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash
          c
          cpp
          css
          go
          html
          javascript
          json
          latex
          lua
          make
          markdown
          markdown_inline
          nix
          python
          regex
          rust
          toml
          tsx
          typescript
          vim
          vimdoc
          xml
          yaml
        ];
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
          };
        };
      };
    };

    # nvim-lspconfig menyediakan default config; server diaktifkan lewat modul lsp.
    plugins.lspconfig.enable = true;

    lsp = {
      servers = {
        lua_ls.enable = true;
        marksman.enable = true;
        nixd.enable = true;
        ts_ls.enable = true;
      };

      keymaps = [
        {
          key = "gd";
          lspBufAction = "definition";
        }
        {
          key = "gD";
          lspBufAction = "references";
        }
        {
          key = "K";
          lspBufAction = "hover";
        }
        {
          key = "<leader>rn";
          lspBufAction = "rename";
        }
        {
          key = "<leader>ca";
          lspBufAction = "code_action";
        }
        {
          key = "<leader>d";
          action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        }
      ];
    };

    # Dipakai keymap <leader>mp. Pakai list argumen supaya tidak lewat shell.
    userCommands = {
      MdToPdf = {
        command = config.lib.nixvim.mkRaw ''
          function()
            local file = vim.api.nvim_buf_get_name(0)
            if file == "" then
              vim.notify("Simpan file dulu sebelum convert ke PDF", vim.log.levels.WARN)
              return
            end

            local ext = vim.fn.fnamemodify(file, ":e"):lower()
            if ext ~= "md" and ext ~= "markdown" then
              vim.notify("File ini bukan Markdown", vim.log.levels.WARN)
              return
            end

            -- Pastikan versi terbaru di buffer ikut ter-convert.
            if vim.bo.modified then
              local saved, err = pcall(vim.cmd, "silent write")
              if not saved then
                vim.notify("Gagal menyimpan file: " .. tostring(err), vim.log.levels.ERROR)
                return
              end
            end

            local out = vim.fn.fnamemodify(file, ":r") .. ".pdf"
            local dir = vim.fn.fnamemodify(file, ":p:h")

            -- Header LaTeX: code block gelap ala Tokyo Night, syntax tetap terbaca.
            local header = vim.fn.tempname() .. ".tex"
            local header_file = io.open(header, "w")
            if not header_file then
              vim.notify("Gagal membuat header LaTeX", vim.log.levels.ERROR)
              return
            end
            header_file:write([[
\usepackage{tcolorbox}
\usepackage{etoolbox}
\usepackage{fvextra}
\tcbuselibrary{breakable}

% Pandoc hanya mendefinisikan environment kode kalau ada code block.
\ifdefined\Highlighting\else
  \DefineVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\{\}}
\fi
\ifdefined\Shaded\else
  \newenvironment{Shaded}{}{}
\fi

${imagePlacement}
${inlineCodePreamble}
\definecolor{CodeBg}{HTML}{1A1B26}
\definecolor{CodeFg}{HTML}{C0CAF5}
\definecolor{CodeComment}{HTML}{565F89}
\definecolor{CodeRed}{HTML}{F7768E}
\definecolor{CodeGreen}{HTML}{9ECE6A}
\definecolor{CodeYellow}{HTML}{E0AF68}
\definecolor{CodeBlue}{HTML}{7AA2F7}
\definecolor{CodeMagenta}{HTML}{BB9AF7}
\definecolor{CodeCyan}{HTML}{7DCFFF}
\definecolor{CodeOrange}{HTML}{FF9E64}

\AtBeginEnvironment{Highlighting}{\fontsize{${toString codeFontSize}}{${toString (codeFontSize + 2)}}\selectfont\color{CodeFg}}

% Inline code (`...`): font code + background tipis, tetap bisa wrap.
${inlineCodeCommand}

\RecustomVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\{\},${codeLineNumberOptions}${codeWrapOptions}}
\renewcommand{\theFancyVerbLine}{\rmfamily\tiny\textcolor{CodeComment}{\arabic{FancyVerbLine}}}

\def\AlertTok#1{\textcolor{CodeRed}{\textbf{#1}}}
\def\AnnotationTok#1{\textcolor{CodeComment}{\textbf{\textit{#1}}}}
\def\AttributeTok#1{\textcolor{CodeYellow}{#1}}
\def\BaseNTok#1{\textcolor{CodeOrange}{#1}}
\def\BuiltInTok#1{\textcolor{CodeCyan}{#1}}
\def\CharTok#1{\textcolor{CodeGreen}{#1}}
\def\CommentTok#1{\textcolor{CodeComment}{\textit{#1}}}
\def\CommentVarTok#1{\textcolor{CodeComment}{\textbf{\textit{#1}}}}
\def\ConstantTok#1{\textcolor{CodeOrange}{#1}}
\def\ControlFlowTok#1{\textcolor{CodeMagenta}{\textbf{#1}}}
\def\DataTypeTok#1{\textcolor{CodeCyan}{#1}}
\def\DecValTok#1{\textcolor{CodeOrange}{#1}}
\def\DocumentationTok#1{\textcolor{CodeComment}{\textit{#1}}}
\def\ErrorTok#1{\textcolor{CodeRed}{\textbf{#1}}}
\def\ExtensionTok#1{\textcolor{CodeCyan}{#1}}
\def\FloatTok#1{\textcolor{CodeOrange}{#1}}
\def\FunctionTok#1{\textcolor{CodeBlue}{#1}}
\def\ImportTok#1{\textcolor{CodeMagenta}{#1}}
\def\InformationTok#1{\textcolor{CodeCyan}{#1}}
\def\KeywordTok#1{\textcolor{CodeMagenta}{\textbf{#1}}}
\def\NormalTok#1{\textcolor{CodeFg}{#1}}
\def\OperatorTok#1{\textcolor{CodeCyan}{#1}}
\def\OtherTok#1{\textcolor{CodeFg}{#1}}
\def\PreprocessorTok#1{\textcolor{CodeMagenta}{#1}}
\def\RegionMarkerTok#1{\textcolor{CodeComment}{#1}}
\def\SpecialCharTok#1{\textcolor{CodeYellow}{#1}}
\def\SpecialStringTok#1{\textcolor{CodeGreen}{#1}}
\def\StringTok#1{\textcolor{CodeGreen}{#1}}
\def\VariableTok#1{\textcolor{CodeFg}{#1}}
\def\VerbatimStringTok#1{\textcolor{CodeGreen}{#1}}
\def\WarningTok#1{\textcolor{CodeYellow}{\textbf{#1}}}

\renewenvironment{Shaded}
  {\begin{tcolorbox}[
     breakable,
     ${codeBoxOptions}left=${codeBoxLeftPadding}, right=6pt, top=5pt, bottom=5pt,
   ]}
  {\end{tcolorbox}}
]])
            header_file:close()

            local result = vim.fn.system({
              "pandoc",
              file,
              "-o",
              out,
              "--pdf-engine=lualatex",
              "--lua-filter=${breakableInlineCodeFilter}",
              "--resource-path=" .. dir,
              "-H", header,
              "-V", "geometry:a4paper",
              "-V", "geometry:margin=2.5cm",
              "-V", "fontsize=11pt",
              "-V", "linestretch=1.15",
              "-V", "mainfont=Inter",
              "-V", "monofont=JetBrainsMono Nerd Font",
              "-V", "colorlinks=true",
            })
            vim.fn.delete(header)

            if vim.v.shell_error == 0 then
              vim.notify("PDF dibuat: " .. out, vim.log.levels.INFO)
            else
              vim.notify("Gagal membuat PDF:\n" .. result, vim.log.levels.ERROR)
            end
          end
        '';
        desc = "Convert current Markdown file to PDF";
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<cr>";
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<cr>";
        options.desc = "Help tags";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Telescope file_browser<cr>";
        options.desc = "File browser (c: create, r: rename, d: delete)";
      }
      {
        mode = "n";
        key = "<leader>E";
        action = "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>";
        options.desc = "File browser at current file";
      }
      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>ToggleTerm direction=float<cr>";
        options.desc = "Toggle floating terminal";
      }
      {
        mode = "n";
        key = "<leader>th";
        action = "<cmd>ToggleTerm direction=horizontal<cr>";
        options.desc = "Toggle horizontal terminal";
      }
      {
        mode = "n";
        key = "<leader>tv";
        action = "<cmd>ToggleTerm direction=vertical<cr>";
        options.desc = "Toggle vertical terminal";
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<cr>";
        options.desc = "Lazygit (commit, push, pull, branch)";
      }
      {
        mode = "n";
        key = "<leader>gf";
        action = "<cmd>LazyGitCurrentFile<cr>";
        options.desc = "Lazygit for current file";
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>LazyGitFilter<cr>";
        options.desc = "Lazygit log";
      }
      {
        mode = "n";
        key = "<leader>mi";
        action = "<cmd>PasteImage<cr>";
        options.desc = "Paste image from clipboard";
      }
      {
        mode = "n";
        key = "<leader>mp";
        action = "<cmd>MdToPdf<cr>";
        options.desc = "Convert Markdown to PDF";
      }
      {
        mode = "n";
        key = "<leader>mr";
        action = "<cmd>RenderMarkdown toggle<cr>";
        options.desc = "Toggle Markdown rendering";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<cr>";
        options.desc = "Delete buffer";
      }
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<cr>";
        options.desc = "Clear search highlight";
      }
    ];

    extraPackages = with pkgs; [
      fd
      neovim-remote
      nixfmt
      ripgrep
      stylua
      wl-clipboard
    ];
  };
}
