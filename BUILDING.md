# Building the book: notes for Claude

This repository holds the LaTeX source for *Semantic Web for the Working Ontologist*
(3rd edition, ACM book class). This file is for an AI assistant asked to build the PDF,
especially on macOS. Read it through before running anything.

## What to run, and where

Run everything from the **top level of the repository** (the folder that contains this file
and the `SWWOv3/` subfolder). Do not run from inside `SWWOv3/`.

```
latexmk SWWOv3/SWWOv3.tex
```

- The output is `SWWOv3.pdf` in the top level. It is about 483 pages.
- The build uses XeLaTeX. `.latexmkrc` at the top level sets the engine and the search paths,
  so no extra flags are needed.
- Expected result: exit code 0, no `!` errors, no undefined citations or references. One
  warning is normal: `Label chal:26 multiply defined`.
- To remove build output: `latexmk -C SWWOv3/SWWOv3.tex`.
- Build output (`*.aux`, `*.xdv`, `*.pdf`, and so on) is git-ignored. Do not commit it.

The main file is `SWWOv3/SWWOv3.tex`. It uses the class `SWWOv3/acm-book.cls`, the
bibliography `SWWOv3/refs.bib`, and the chapters `SWWOv3/chap01.tex` to `chap17.tex`. Figures
live in `SWWOv3/media/`. The chapters refer to them as `media/...`, which resolves because
`.latexmkrc` adds `SWWOv3/` to the search path.

## What to install on a MacBook

1. **A TeX distribution with XeLaTeX and latexmk.** Install **MacTeX** (about 5 GB, includes
   everything the book needs). Use the full MacTeX, not BasicTeX: BasicTeX needs many extra
   packages added by hand. After installing, check with `which xelatex latexmk`.
   Open a new terminal afterwards so the PATH updates.
2. **Git**, if it is not already installed (`xcode-select --install` provides it).
3. No Ghostscript install is needed separately. MacTeX includes it. If `epstopdf` complains
   about Ghostscript, install it with Homebrew: `brew install ghostscript`.

Getting the source:

```
git clone -b masterv4 https://github.com/dallemang/SWWOv3.git
cd SWWOv3
latexmk SWWOv3/SWWOv3.tex
```

Use the `masterv4` branch. The `master` branch is older and does not contain these build fixes.

## Things that differ on macOS

- **Fonts.** `SWWOv3/SWWOv3.tex` picks the CJK and Arabic fonts that are installed:
  - CJK (Chinese): `SimSun` (Windows) if present, otherwise `Songti SC` (ships with macOS).
  - Arabic: `Arial` if present, otherwise `Geeza Pro` (ships with macOS).

  This selection was added so the build works on macOS without edits. It has been tested on
  Windows, and the fallback branch has been compiled in a small test. The full book has not
  yet been built on a Mac. If the Chinese or Arabic example looks wrong or the build reports
  a missing font, check the names with `fc-list` or Font Book.
- **Path separator.** `.latexmkrc` uses `:` on macOS and `;` on Windows. Do not change this.
- **Paths.** Always run from the top level. If you see `File acm-book.cls not found`, you are
  in the wrong folder, or `.latexmkrc` is missing.

## Windows (for reference)

Windows uses MiKTeX, which installs packages on demand. Run the same `latexmk` command from
the top level. The fonts `SimSun` and `Arial` are present by default.

## Known open items (not build errors)

- Label `chal:26` is defined twice. This causes the one warning above.
- The FIBO citation was changed to `fiboprimer`, which renders as `[EDMCouncil 2018]`. The
  keys `fibospec` and `fiboweb` in `SWWOv3/refs.bib` are no longer cited.
- The Arabic example URL in `chap05.tex` (around line 107) includes a stray `.tn/` that the
  author may want to check.
