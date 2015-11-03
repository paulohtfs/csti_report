TARGET = REPORT.pdf

BIBTEX = bibtex
LATEX = latex
DVIPS = dvips
PS2PDF = ps2pdf

STATIC_DIR = static
STATIC_SOURCES = header.tex
STATIC_FILES = $(addprefix $(STATIC_DIR)/, $(STATIC_SOURCES))

BIBLIOGRAPHY_FILE = bibliography.bib

MAIN_FILE = report.tex
DVI_FILE  = $(addsuffix .dvi, $(basename $(MAIN_FILE)))
AUX_FILE  = $(addsuffix .aux, $(basename $(MAIN_FILE)))
PS_FILE   = $(addsuffix .ps,  $(basename $(MAIN_FILE)))
PDF_FILE  = $(addsuffix .pdf, $(basename $(MAIN_FILE)))

SOURCE = $(STATIC_FILES)


all:
	@make $(TARGET)

$(TARGET): $(MAIN_FILE) $(SOURCE) $(BIBLIOGRAPHY)
	$(LATEX) $(MAIN_FILE) $(SOURCE)
	$(BIBTEX) $(AUX_FILE)
	$(LATEX) $(MAIN_FILE) $(SOURCE)
	$(LATEX) $(MAIN_FILE) $(SOURCE)
	dvipdfmx $(DVI_FILE)
	#$(DVIPS) $(DVI_FILE)
	#$(PS2PDF) $(PS_FILE)
	@cp $(PDF_FILE) $(TARGET)

clean:
	rm -f *~ *.dvi *.ps *.backup *.aux *.log
	rm -f *.lof *.lot *.bbl *.blg *.blg *.brf *.toc *.idx
	rm -f *.pdf
