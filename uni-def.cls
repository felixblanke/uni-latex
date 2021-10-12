%%
%% IDENTIFICATION
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uni-latex/uni-def}[Class for layouting summaries of lectures]

%%
%% OPTIONS
%%

\RequirePackage{kvoptions}      % Allows Key-Value Options

\SetupKeyvalOptions{
    family=UNI,
    prefix=UNI@
}

% use option pair draft/final
\DeclareBoolOption{draft}
\DeclareComplementaryOption{final}{draft}

\DeclareStringOption[Zusammenfassung]{subject}
\DeclareStringOption[Mustervorlesung]{lecture}
\DeclareStringOption[Max Musterautor]{author}
\DeclareStringOption[Musterautor]{authorshort}
\DeclareStringOption[]{subtitle}

\DeclareStringOption[\today]{date}

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
%    twoside,
    headsepline
    ]{scrartcl}

\KOMAoptions{%
  DIV=\UNI@DIV,%
  parskip=\UNI@parskip,%
  fontsize=\UNI@fontsize%
}

\RequirePackage{iftex}%       % check if one is using pdftex
\ifpdftex
  \wlog{PDF LaTeX detected}
  \RequirePackage[utf8]{inputenc}% Input-Encoding UTF-8
  \RequirePackage[T1]{fontenc}   % Font-Encoding
  \RequirePackage{libertinus}    % use libertinus fonts
\else
  \RequirePackage{fontspec}
  \RequirePackage{unicode-math}

  \setmainfont[
    Ligatures   = TeX,
    Numbers     = OldStyle,
    Contextuals = Alternate
  ]{Libertinus Serif}
  \setsansfont[
    Ligatures   = TeX,
    Numbers     = OldStyle,
    Contextuals = Alternate
  ]{Libertinus Sans}
  \setmonofont[Scale=MatchLowercase]{Inconsolatazi4}
  \setmathfont{Libertinus Math}
  % Set the text main font to Libertinus Serif via "fontspec".
  % Set the sans main font to Libertinus Sans.
  % Set the math font to Libertinus Math.
  % Enables text figures, fancy "Qu" (contextual alternates).
  % Ensures that -- is translated into an endash (TeX ligature).

  \newfontfamily{\headingfont}{Libertinus Sans}[
    Ligatures     = TeX,
    Numbers       = OldStyle,
    Contextuals   = Alternate,
    StylisticSet  = 6
  ]
  \addtokomafont{disposition}{\headingfont}
  % Fancy version of Libertinus Sans for headings,
  % using text figures, fancy ampersand (ss06).

  \newfontfamily{\rmlffamily}{Libertinus Serif}
  \newfontfamily{\sflffamily}{Libertinus Sans}
  % Makes it possible to disable text figures.
\fi

\RequirePackage{babel}%         % localisation

\RequirePackage{amsthm}%        % theorem environments etc.
\RequirePackage{xparse}%        % allows improved definition of commands

\RequirePackage[%               % improved enumerations etc.
    shortlabels%                %     allows shorthand notation
]{enumitem}

%%
%% TRANSLATIONS
%%
\providecommand*{\UNI@dateprefix}{\UNI@lang@error{\UNI@dateprefix}}
\providecommand*{\UNI@definitionname}{\UNI@lang@error{\UNI@definitionname}}
\providecommand*{\UNI@examplename}{\UNI@lang@error{\UNI@examplename}}
\providecommand*{\UNI@propositionname}{\UNI@lang@error{\UNI@propositionname}}
\providecommand*{\UNI@theoremname}{\UNI@lang@error{\UNI@theoremname}}
\providecommand*{\UNI@lemmaname}{\UNI@lang@error{\UNI@lemmaname}}
\providecommand*{\UNI@corollaryname}{\UNI@lang@error{\UNI@corollaryname}}
\providecommand*{\UNI@remarkname}{\UNI@lang@error{\UNI@remarkname}}

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
\providecaptionname{ngerman}{\UNI@dateprefix}{Stand:}%
\providecaptionname{ngerman}{\UNI@definitionname}{Definition}%
\providecaptionname{ngerman}{\UNI@examplename}{Beispiel}%
\providecaptionname{ngerman}{\UNI@propositionname}{Proposition}%
\providecaptionname{ngerman}{\UNI@theoremname}{Satz}%
\providecaptionname{ngerman}{\UNI@lemmaname}{Lemma}%
\providecaptionname{ngerman}{\UNI@corollaryname}{Korollar}%
\providecaptionname{ngerman}{\UNI@remarkname}{Bemerkung}%
%
\providecaptionname{english}{\UNI@dateprefix}{as at}%
\providecaptionname{english}{\UNI@definitionname}{Definition}%
\providecaptionname{english}{\UNI@examplename}{Example}%
\providecaptionname{english}{\UNI@propositionname}{Proposition}%
\providecaptionname{english}{\UNI@theoremname}{Theorem}%
\providecaptionname{english}{\UNI@lemmaname}{Lemma}%
\providecaptionname{english}{\UNI@corollaryname}{Corollary}%
\providecaptionname{english}{\UNI@remarkname}{Remark}%
}%

\ifUNI@draft
    % draft watermark
    \RequirePackage{draftwatermark}
    \SetWatermarkText{Entwurf}

    % Use draft mode of KoMa class
    \KOMAoptions{draft}
\fi

% loaded here to overwrite KOMAoption "draft"
\RequirePackage[%               % headers and footers
    draft=false%                % don't show draft info in header/footer
]{scrlayer-scrpage}

%%
%% Layout
%%

\setlist[enumerate, 1]{%
label=(\roman*)%
}

% use French spacing, i.e. no additional space after periods that end sentences.
\frenchspacing

% Theoremstyles
\theoremstyle{definition}
\newtheorem{defi}{\UNI@definitionname}[section]
\newtheorem{example}[defi]{\UNI@examplename}

\theoremstyle{plain}
\newtheorem{prop}[defi]{\UNI@propositionname}
\newtheorem{theorem}[defi]{\UNI@theoremname}
\newtheorem{lemma}[defi]{\UNI@lemmaname}
\newtheorem{cor}[defi]{\UNI@corollaryname}

\theoremstyle{remark}
\newtheorem*{remark}{\UNI@remarkname} %No counter

%%
%% Title
%%

\newcommand* \SetupLecture [1] {
  \setkeys{UNI}{lecture={#1}}
}
\newcommand* \SetupSubtitle [1] {
  \setkeys{UNI}{subtitle={#1}}
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

\AtBeginDocument{
  \subject{\UNI@subject}
  \title{\UNI@lecture}
  \subtitle{\UNI@subtitle}
  \author{\UNI@author}
  \date{\UNI@dateprefix~\UNI@date}
%  \titlehead{Kopf über den Titel}
%  \date{}
%  \publishers{Betreuer o.Ä.}

  \ohead{%
    \ifx\UNI@subject\@empty%
    \else%
      \UNI@subject\ --\ %
    \fi%
    \UNI@lecture\ -- \UNI@authorshort%
  }
}
