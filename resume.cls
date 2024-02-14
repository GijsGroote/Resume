\ProvidesClass{resume}
\LoadClass[11pt,letterpaper]{article} % Font size and paper type

\RequirePackage[parfill]{parskip} % Remove paragraph indentation
\RequirePackage{array} % Required for boldface (\bf and \bfseries) tabular columns

\RequirePackage{zref-savepos}
\RequirePackage{xcolor}
\RequirePackage{framed}
\PassOptionsToPackage{dvipsnames,svgnames}{xcolor}
\definecolor{themecolor}{HTML}{a91b27}
\definecolor{urlcolor}{HTML}{204487}
\RequirePackage{titlesec}
\RequirePackage{fontawesome5}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{hyperref}
\hypersetup{%
    colorlinks=true,
    urlcolor=blue,
    pdftitle={resume},
    }

\usepackage[left=0.75in,top=0.6in,right=0.75in,bottom=0.6in]{geometry} % Document margins



% For the picture
\RequirePackage{tikz}
\RequirePackage{float}
\newcommand{\roundpic}[1]{\begin{tikzpicture}[remember picture,overlay]
    \node[xshift=130.345mm,yshift=4.5mm,anchor=north west] at (current page.north west){%
    \includegraphics[height=70mm]{#1}};
\end{tikzpicture}}

\pagestyle{empty} % Suppress page numbers

%----------------------------------------------------------------------------------------
%	HEADINGS COMMANDS: Commands for printing name and address
%----------------------------------------------------------------------------------------

\def \name#1{\def\@name{#1}} % Defines the \name command to set name
\def \@name {} % Sets \@name to empty by default

\def \profession#1{\def\@profession{#1}} % Defines the \profession command to set provession
\def \@profession {} % Sets \@provession to empty by default

\def \addressSep {$\diamond$} % Set default address separator to a diamond

% One, two or three address lines can be specified
\let \@addressone \relax
\let \@addresstwo \relax
\let \@addressthree \relax

% \address command can be used to set the first, second, and third address (last 2 optional)
\def \address #1{
  \@ifundefined{@addresstwo}{
    \def \@addresstwo {#1}
  }{
  \@ifundefined{@addressthree}{
  \def \@addressthree {#1}
  }{
     \def \@addressone {#1}
  }}
}

% \printaddress is used to style an address line (given as input)
\def \printaddress #1{
  \begingroup
    \def \\ {\addressSep\ }
    \centerline{#1}
  \endgroup
  \par
  \addressskip
}

% \printname is used to print the name as a page header
\def \printname {
  \begingroup
    \hfil{\namesize\bf \@name}\hfil
    \nameskip\break\par
  \endgroup
}

% \printprofession
\def \printprofession{
    \vspace{-.7cm}
    \begingroup
      \hfil{\Large\MakeUppercase \@profession}\hfil
      \nameskip\break
    \endgroup
    \vspace{-.5cm}
}

%----------------------------------------------------------------------------------------
%	PRINT THE HEADING LINES
%----------------------------------------------------------------------------------------

\let\ori@document=\document
\renewcommand{\document}{
  \ori@document  % Begin document
  
  \printname % Print the name specified with \name
  \printprofession

  \@ifundefined{@addressone}{}{ % Print the first address if specified
    \printaddress{\@addressone}}
  \@ifundefined{@addresstwo}{}{ % Print the second address if specified
    \printaddress{\@addresstwo}}
     \@ifundefined{@addressthree}{}{ % Print the third address if specified
    \printaddress{\@addressthree}}
}

%----------------------------------------------------------------------------------------
%	SECTION FORMATTING
%----------------------------------------------------------------------------------------

\newcommand{\craisedrule}[2][0em]{\leaders\hbox{\rule[#1]{1pt}{#2}}\hfill\hspace{-0.325cm}}
\newcommand{\cfilll}[2][1ex]{
\dimen0=#2\advance\dimen0 by #1
\color{themecolor}\craisedrule{2pt}}


\newcommand{\raisedrule}[2][0em]{\leaders\hbox{\rule[#1]{1pt}{#2}}\hfill\hspace{-1.1cm}}
\newcommand{\xfilll}[2][1ex]{
\dimen0=#2\advance\dimen0 by #1
\color{themecolor}\raisedrule{2pt}}

% Adjusting the margins
\enlargethispage{2\baselineskip} % you can adjust the number based on your content's fit in the page
% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
  % \begin{framed}
  \sectionskip
  \section*{{\LARGE \MakeUppercase{\bf #1}}\xfilll[0pt]{1.5pt}}

  \vspace{-.3cm}
  \begin{list}{}{ % List for each individual item in the section
    \setlength{\leftmargin}{1.5em} % Margin within the section
  }
  \item[]
}{
  \end{list}
  \vspace{-.2cm}
% \end{framed}
}

%----------------------------------------------------------------------------------------
%	WORK EXPERIENCE FORMATTING
%----------------------------------------------------------------------------------------

\newenvironment{experienceItem}[4]{ 
  % \ifthenelse{\larger{\currentpos{text}{100pt}}{\newpage}{}
  % 4 input arguments - text for top left, top right, bottom left and bottom right
  {\bf #1} \hfill {#2}
  \ifthenelse{\equal{#3}{}}{\vspace{-0.05cm}\\}{   \\
    {\em #3} \hfill {\em #4} \vspace{-0.5cm}\\
  }
}{}

% \newcommand*{\currpos}[1]{%
%   \zsavepos{#1}%

%   (\zposx{#1}sp, \zposy{#1}sp) =
%   % (\the\dimexpr\zposx{#1}sp\relax, \the\dimexpr\zposy{#1}sp\relax)%
% \the\dimexpr\zposx{#1}sp\relax
% % \ifnum{\value{\zposx{#1}}}>30 {A} \else {B}\fi
%   % larger than 200?
%   % \ifthenelse{\value{\zposx{#1}}>{200}}{yes, that larger}{no, not larger}  
% }


% Adjusting the margins
% \enlargethispage{2\baselineskip}
\newenvironment{cSection}[5]{ \sectionskip
  \centering
  \begin{minipage}{#1}

  \begin{minipage}{#2}
  {#4}
  \end{minipage}
  \hfill
  \begin{minipage}{#3}
  {#5}
  \end{minipage}
}
{
  \end{minipage}
}

\newenvironment{cSubsection}[1]{ % 5 input arguments - environment width, company name, year(s) employed, job title and location
  \section*{{\LARGE \MakeUppercase{\bf #1}}\cfilll[0pt]{1.5pt}}
  \vspace{-0.2cm}

  \begin{list}{}{ % List for each individual item in the section
    \setlength{\leftmargin}{1.5em} % Margin within the section
  }
  \item[]
}{
  \end{list}
  \vspace{-0.3cm}
}


% The below commands define the whitespace after certain things in the document - they can be \smallskip, \medskip or \bigskip
\def\namesize{\huge} % Size of the name at the top of the document
\def\addressskip{\smallskip} % The space between the two address (or phone/email) lines
\def\sectionlineskip{\medskip} % The space above the horizontal line for each section
\def\nameskip{\bigskip} % The space after your name at the top
\def\sectionskip{\medskip} % The space after the heading section
