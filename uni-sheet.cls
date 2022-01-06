%%
%% IDENTIFICATION
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uni-latex/uni-sheet}[2021-04-25 Class for layouting solutions to exercise sheets]

%%
%% OPTIONS
%%

\RequirePackage{kvoptions}      % Allows Key-Value Options

\SetupKeyvalOptions{
    family=UNI,
    prefix=UNI@
}%

% use option pair draft/final
\DeclareBoolOption{draft}
\DeclareComplementaryOption{final}{draft}

\DeclareStringOption[Vorlesung]{subject}
\DeclareStringOption[Mustervorlesung]{lecture}
\DeclareStringOption[00]{sheetno}
\DeclareStringOption[Max Musterautor]{author}
\DeclareStringOption[Musterautor]{authorshort}
\DeclareStringOption[]{subtitle}

\DeclareStringOption[12]{DIV}
\DeclareStringOption[half]{parskip}
\DeclareStringOption[12pt]{fontsize}

% pass all other options to the document class
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{scrartcl}}

% process all options
\ProcessKeyvalOptions*

%%
%% LOADING PACKAGES
%%

% load the class "scrartcl" from the KoMa-Script bundle
\LoadClass[%
    a4paper,
    twoside
    ]{scrartcl}
    
\KOMAoptions{%
  DIV=\UNI@DIV,%
  parskip=\UNI@parskip,%
  fontsize=\UNI@fontsize%
}

\RequirePackage{iftex}%       % check if one is using pdftex
\ifpdftex
  \RequirePackage[utf8]{inputenc}% Input-Encoding UTF-8
  \RequirePackage[T1]{fontenc}   % Font-Encoding
  \RequirePackage{lmodern}       % LModern font
\fi

\RequirePackage{babel}%          %localisation

\RequirePackage{xparse}       % Verbesserte Definition von Befehlen
\RequirePackage[%               % bessere Aufzählungen
    shortlabels%                %     erlaubt Kurzschreibweise der Labels an Aufzählungen
]{enumitem}

%%
%% TRANSLATIONS
%%
\providecommand*{\UNI@exerciseprefix}{\UNI@lang@error{\UNI@exerciseprefix}}
\providecommand*{\UNI@sheetprefix}{\UNI@lang@error{\UNI@sheetprefix}}
\providecommand*{\UNI@draftname}{\UNI@lang@error{\UNI@draftname}}

\newcommand*{\UNI@lang@error}[1]{%
  \ClassError{uni-def}{%
    current language not supported%
  }{%
    Currently uni-def only supports languages ``ngerman'' and
    ``english''.\MessageBreak
    It seems, that you are using another language (maybe
    \languagename).\MessageBreak
    Because of this you have to define \string#1\space by
    yourself!\MessageBreak
  }%
  \textbf{??}%
}

\AtBeginDocument{%
\providecaptionname{ngerman}{\UNI@exerciseprefix}{Aufgabe}%
\providecaptionname{ngerman}{\UNI@sheetprefix}{Blatt}%
\providecaptionname{ngerman}{\UNI@draftname}{Entwurf}%
%
\providecaptionname{english}{\UNI@exerciseprefix}{Exercise}%
\providecaptionname{english}{\UNI@sheetprefix}{Sheet}%
\providecaptionname{english}{\UNI@draftname}{Draft}%
}

\ifUNI@draft
    % Entwurfs-Wasserzeichen
    \RequirePackage{draftwatermark}
    \SetWatermarkText{\UNI@draftname}

    % Use draft mode of KoMa class
    \KOMAoptions{draft}
\fi

% Hier eingebunden, da die KOMAoption "draft" überschrieben werden muss
\RequirePackage[%               % Kopf- und Fußzeilen.
    draft=false%                % Verhindert das Anzeigen von "Entwurfs-Informationen"
]{scrlayer-scrpage}


%%
%% Layout
%%


\setlist[enumerate, 1]{%
label=(\roman*)%
}

% use French spacing
\bbl@frenchspacing

%% Excercise

% ToDo: Change TOC appearance
\DeclareNewSectionCommand[%
style=section,            %
%counterwithin=,          %
afterskip=1em,            %
beforeskip=0pt,           %
level=1,                  %
afterindent=false,        %
font=\normalsize,         %
indent=0pt,               %
runin=true,               %
tocindent=1.5em,          %
toclevel=1,               %
tocnumwidth=2.3em,        %
tocstyle=section          %
]{exercise}

\addtokomafont{exercise}{\normalfont\rmfamily}
\renewcommand \theexercise {\arabic{exercise}}
\renewcommand\exerciseformat{{\bfseries\UNI@exerciseprefix~\theexercise.}}

% Define shorthand
\newcommand* \ex {\exercise{}}

%% Sub-Excercise

% ToDo: Change TOC appearance
\DeclareNewSectionCommand[%
style=section,            %
counterwithin=exercise,   %
afterskip=1em,            %
beforeskip=0pt,           %
level=2,                  %
afterindent=false,        %
font=\normalsize,         %
indent=0pt,%-2.5em,               %
runin=true,               %
tocindent=1.5em,          %
toclevel=2,               %
tocnumwidth=2.3em,        %
tocstyle=section          %
]{subexercise}

\addtokomafont{subexercise}{\normalfont\rmfamily}
\renewcommand \thesubexercise {\theexercise\,(\alph{subexercise})}
\renewcommand \subexerciseformat {(\alph{subexercise})}


% Define shorthand
\newcommand* \subex {\subexercise{}}

\newcommand{\ifnotext}[1]{%
  \sbox0{#1}%
  \ifdim\wd0=0pt
}

\renewcommand \sectioncatchphraseformat [4] {%
  \Ifstr{#1}{exercise}{%
	\ifnotext{#4}% check if #4 is empty (except for formatting)
      \hskip #2#3% exercise name empty
    \else%
      \hskip #2#3~(#4)%
    \fi%
  }{%
    \hskip #2#3#4%
  }%
}


%%
%% Title
%%

\newcommand* \SetupLecture [1] {
  \setkeys{UNI}{lecture={#1}}
}
\newcommand* \SetupSheetno [1] {
  \setkeys{UNI}{sheetno={#1}}
}
\NewDocumentCommand \SetupAuthor {O{#2} m} {
  \setkeys{UNI}{authorshort={#1}}%
  \setkeys{UNI}{author={#2}}%
}
\newcommand* \SetupSubject [1] {
  \setkeys{UNI}{subject={#1}}
}
\newcommand* \SetupDate [1] {
  \setkeys{UNI}{date={#1}}
}

\pagestyle{scrheadings}
\KOMAoptions{headsepline=true}

\AtBeginDocument{
  \subject{\UNI@subject}
  \title{\UNI@lecture}
  \subtitle{\UNI@subtitle}
  \subtitle{\UNI@sheetprefix~\UNI@sheetno}
  \author{\UNI@author}

%  \titlehead{Kopf über den Titel}
%  \date{}
%  \publishers{Betreuer o.Ä.}

  \ohead{
    \ifx \UNI@subject \@empty
    \else
      \UNI@subject~
    \fi
    \UNI@lecture\ -- \UNI@authorshort%
  }
}
