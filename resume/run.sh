OUTPUT_FILENAME="../static/daniel-young-résumé.pdf"

typst compile resume.typ $OUTPUT_FILENAME

zathura $OUTPUT_FILENAME &

typst watch resume.typ $OUTPUT_FILENAME
