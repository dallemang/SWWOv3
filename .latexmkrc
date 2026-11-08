# latexmk settings for building the book from the repository root:
#   latexmk SWWOv3/SWWOv3.tex
# The main file and the class/style/bib files live in SWWOv3/, so TeX, BibTeX
# and the BST lookup must be told to search there too. See BUILDING.md.

# 5 = XeLaTeX (the book uses fontspec and xeCJK).
$pdf_mode = 5;

# Path separator: ';' on Windows, ':' on macOS and Linux.
# Perl reports 'msys' or 'cygwin' under Git Bash, so match those as Windows too.
my $sep = ($^O =~ /MSWin32|msys|cygwin/) ? ';' : ':';
for my $var ('TEXINPUTS', 'BIBINPUTS', 'BSTINPUTS') {
    $ENV{$var} = "SWWOv3//$sep" . ($ENV{$var} // '');
}
