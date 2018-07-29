
#' Create homoglyphs from twin strings
#'
#' @param a first string for matching
#' @param b second string for matching
#'
#' @return dataframe of pairs of homoglyphs
#'
#' @examples
#'
#' get_homoglyphs("www.macdonalds.com", "vvwvv.rnacd0naIcls.c0rn")
#'
#' @importFrom dplyr as_tibble
#' @export
get_homoglyphs <- function(a,b){
  stopifnot(is.character(a) && length(a)==1)
  stopifnot(is.character(b) && length(b)==1)

  m <- attr(adist(a,b, counts = TRUE),"trafos")[1,1]

  #aa <- data.frame(x=as.vector(row(m)),
  #                 y=as.vector(col(m)),
  #                 z=as.vector(m), stringsAsFactors = FALSE)
  #p <- strsplit(aa$z[1], "")[[1]]

  p <- strsplit(m, "")[[1]]
  ca <- strsplit(a, "")[[1]]
  cb <- strsplit(b, "")[[1]]

  df <- data.frame(
      wa=ifelse(p!="I", ca[cumsum(p!="I")],""),
      wb=ifelse(p!="D", cb[cumsum(p!="D")],""),
      group=cumsum(abs(as.integer(p!="M") - c(1, head(p!="M", length(p)-1)))),
    stringsAsFactors = FALSE)

  #hdf <- aggregate(cbind(wa, wb) ~ group, data=df, FUN=paste, collapse="")
  #subset(hdf, wa!=wb, select = c(wa, wb))

  hdf <- aggregate(cbind(df$wa, df$wb), by=list(df$group), FUN=paste, collapse="")
  subset(hdf, V1!=V2, select = c(V1, V2))
}
