#!/bin/bash

# This script makes all resumes in both:
# Dutch and English (name resume or cv)
# Summarized and extended (add _ext to name or not)
# With and without a photo (add _no_photo to name or not)

# set -- resume_gsgroote 
#
# set -- resume_gsgroote resume_gsgroote_no_photo resume_gsgroote_ext resume_gsgroote_ext_no_photo cv_gsgroote cv_gsgroote_no_photo cv_gsgroote_ext cv_gsgroote_ext_no_photo

set -- resume_gsgroote resume_gsgroote_no_photo resume_gsgroote_ext resume_gsgroote_ext_no_photo cv_gsgroote cv_gsgroote_no_photo cv_gsgroote_ext cv_gsgroote_ext_no_photo
for resume_name ;do
  echo -e '\n\n'
  echo "Create: $resume_name.pdf"

  if [[ "$resume_name" == *"no_photo"* ]]; then USE_PHOTO='false'; else USE_PHOTO='true'; fi
  if [[ "$resume_name" == *"resume"* ]]; then USA_LANGUAGE='english'; else USE_LANGUAGE='dutch'; fi
  if [[ "$resume_name" == *"_ext"* ]]; then EXTEND='true'; else EXTEND='false'; fi;

  pdflatex -interaction=batchmode "\def\usephoto{$USE_PHOTO} \def\useLanguage{$USE_LANGUAGE} \def\extended{$EXTEND} \input{resume.tex}" 

  mv resume.pdf ./pdfs/resumes/$resume_name.pdf

done
