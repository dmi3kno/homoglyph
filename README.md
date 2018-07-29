
<!-- README.md is generated from README.Rmd. Please edit that file -->

# homoglyph <img src="man/figures/logo.png" align="right" />

The goal of **`homoglyph`** is to assist the data analyst working with
data coming from noisy data sources (such as OCR) or with text and web
addressess related to online phishing and fraud.

> **homoglyph** (plural homoglyphs)
> 
> A character identical or nearly identical in appearance to another,
> but which differs in the meaning it represents. from Wiktionary, The
> free dictionary\[1\]

The package contains data and functions for creating, processing and
handling homoglyphs. It also contains data and dictionaries that can be
utilized for automatic character matching.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("dmi3kno/homoglyph")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(hocr)
library(tesseract) #install.packages(dmi3kno/tesseract)
library(tidyverse)
library(magick)
```

Lets see if we can produce some homoglyphs from OCR.

``` r
cupcakes <- system.file("extdata", package = "hocr", "peanutbutter.png")

df <- ocr(cupcakes, HOCR = TRUE) %>% 
  hocr_parse() %>% 
  tidy_tesseract()
```

Average confidence score for our text is only 85.1%, so let’s see if we
can improve on this score and create some homoglyphs in the mean time.
We will first aggregate `hocr` to line level.

``` r
df_line <- df %>% select(contains("word"), contains("line")) %>% 
  group_by_at(vars(contains("line"))) %>% 
  mutate(ocrx_line_value=paste(ocrx_word_value, collapse = " "),
         ocrx_line_conf=mean(ocrx_word_conf)) %>%
  group_by(ocrx_line_value, ocrx_line_conf, add = TRUE) %>% 
  nest() %>%
  mutate(ocr_line_geom=bbox_to_geometry(ocr_line_bbox))

test_geom <- df_line %>% filter(ocr_line_id =="line_1_24") %>% pull(ocr_line_geom)

image_read(cupcakes) %>% image_crop(geometry = test_geom)
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" /> To
be continued

## Related projects and further resources

  - [homoglyphs.net](http://homoglyphs.net/)
  - [Unicode
    confusables](https://unicode.org/cldr/utility/confusables.jsp?a=microsoft&r=None)
    and
    [data](http://www.unicode.org/Public/security/latest/confusables.txt)
  - Confusalble homoglyphs a [Python
    project](https://github.com/vhf/confusable_homoglyphs)
  - Bohm, T (2018) Letter and symbol misrecognition in highly legible
    typefaces for general, children, dyslexic, visually impaired and
    ageing readers.
    [Online](https://typography.guru/journal/letters-symbols-misrecognition/)
  - Detecting homoglyph attack with Siamese Neural Network
    [Python](https://github.com/endgameinc/homoglyph)

\[1\] Wiktionary, The free dictionary
<https://en.wiktionary.org/wiki/homoglyph> \[2\] Homoglyph, Wikipedia
article <https://en.wikipedia.org/wiki/Homoglyph>
