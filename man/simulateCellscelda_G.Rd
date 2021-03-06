% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/celda_G.R
\name{simulateCellscelda_G}
\alias{simulateCellscelda_G}
\title{Simulate cells from the celda_G model}
\usage{
simulateCellscelda_G(model, C = 100, NRange = c(500, 1000), G = 100,
  L = 10, beta = 1, gamma = 5, delta = 1, ...)
}
\arguments{
\item{model}{Character. Options available in `celda::availableModels`.}

\item{C}{Integer. Number of cells to simulate. Default 100.}

\item{NRange}{Integer vector. A vector of length 2 that specifies the lower
and upper bounds of the number of counts generated for each cell. Default
c(500, 5000).}

\item{G}{Integer. The total number of features to be simulated. Default 100.}

\item{L}{Integer. Number of feature modules. Default 10.}

\item{beta}{Numeric. Concentration parameter for Phi. Adds a pseudocount to
each feature module in each cell. Default 1.}

\item{gamma}{Numeric. Concentration parameter for Eta. Adds a pseudocount to
the number of features in each module. Default 5.}

\item{delta}{Numeric. Concentration parameter for Psi. Adds a pseudocount to
each feature in each module. Default 1.}

\item{...}{Additional parameters.}
}
\value{
List. Contains the simulated matrix `counts`, feature module clusters
 `y`, and input parameters.
}
\description{
Generates a simulated counts matrix and feature module clusters
 according to the generative process of the celda_G model.
}
\examples{
celdaGSim <- simulateCells(model = "celda_G")
}
\seealso{
`celda_C()` for simulating cell subpopulations and `celda_CG()` for
 simulating feature modules and cell populations.
}
