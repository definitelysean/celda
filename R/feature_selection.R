#' @title Identify features with the highest influence on clustering.
#' @description topRank() can quickly identify the top `n` rows for each column
#'  of a matrix. For example, this can be useful for identifying the top `n`
#'  features per cell.
#' @param matrix Numeric matrix.
#' @param n Integer. Maximum number of items above `threshold` returned for each
#'  ranked row or column.
#' @param margin Integer. Dimension of `matrix` to rank, with 1 for rows, 2 for
#'  columns. Default 2.
#' @param threshold Numeric. Only return ranked rows or columns in the matrix
#'  that are above this threshold. If NULL, then no threshold will be applied.
#'  Default 1.
#' @param decreasing Logical. Specifies if the rank should be decreasing.
#'  Default TRUE.
#' @return List. The `index` variable provides the top `n` row (feature) indices
#'  contributing the most to each column (cell). The `names` variable provides
#'  the rownames corresponding to these indexes.
#' @examples
#' data(sampleCells)
#' topRanksPerCell <- topRank(sampleCells, n = 5)
#' topFeatureNamesForCell <- topRanksPerCell$names[1]
#' @export
topRank <- function(matrix,
    n = 25,
    margin = 2,
    threshold = 0,
    decreasing = TRUE) {

    if (is.null(threshold) || is.na(threshold)) {
        threshold <- min(matrix) - 1
    }

    # Function to sort values in a vector and return 'n' top results
    # If there are not 'n' top results above 'thresh', then the
    # number of entries in 'v' that are above 'thresh' will be returned
    .topFunction <- function(v, n, thresh) {
        vAboveThresh <- sum(v > thresh)
        nToSelect <- min(vAboveThresh, n)

        h <- NA
        if (nToSelect > 0) {
            h <- utils::head(order(v, decreasing = decreasing), nToSelect)
        }
        return(h)
    }

    # Parse top ranked indices from matrix
    topIx <-
        base::apply(matrix, margin, .topFunction, thresh = threshold, n = n)

    # Convert to list if apply converted to a matrix because all
    # elements had the same length
    if (is.matrix(topIx)) {
        topIx <- lapply(seq(ncol(topIx)), function(i)
            topIx[, i])
        names(topIx) <- dimnames(matrix)[[margin]]
    }

    # Parse names from returned margin
    oppositeMargin <-
        ifelse(margin - 1 > 0, margin - 1, length(dim(matrix)))
    topNames <- NULL
    namesToParse <- dimnames(matrix)[[oppositeMargin]]
    if (!is.null(namesToParse) & all(!is.na(topIx))) {
        topNames <- lapply(seq(length(topIx)),
            function(i) {
                ifelse(is.na(topIx[[i]]), NA, namesToParse[topIx[[i]]])
            })
        names(topNames) <- names(topIx)
    }

    return(list(index = topIx, names = topNames))
}
