% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/homoglyph.R
\name{get_homoglyphs}
\alias{get_homoglyphs}
\title{Create homoglyphs from twin strings}
\usage{
get_homoglyphs(a, b)
}
\arguments{
\item{a}{first string for matching}

\item{b}{second string for matching}
}
\value{
dataframe of pairs of homoglyphs
}
\description{
Create homoglyphs from twin strings
}
\examples{

get_homoglyphs("www.macdonalds.com", "vvwvv.rnacd0naIcls.c0rn")

}
