\name{append_dest_origin}
\alias{append_dest_origin}
\title{Reshape data into origin-destination pairs}
\description{
Requires \code{dplyr} and \code{tidyr} packages from \code{tidyverse} to be
installed, \code{origin_dest1} takes as its only argument \code{x} a dataframe
(presumably containing information about locations) and outputs a dataframe
containing all possible origin-destination pairings between the observations
in the dataframe. A typical usage of this function would be to get a dataframe
prepared for the subsequent calculation of distances or drive times between
locations.

\code{origin_dest2} instead takes two arguments/dataframes, one containing the
origins (\code{x}) and the other containing the destinations (\code{y}).

\code{origin_dest1} outputs a dataframe with:

\itemize{
\item{\code{ncol(x)*2} columns;}
\item{\code{(nrow(x))*(nrow(x)-1)} rows.}
}
There are two times as many columns as in the original dataframe because each
observation is now an origin-destination pair. This means that for each
original column in the dataframe there is now an 'origin' column (whose name
is appended with "origin_") and a 'destination' column (whose name is appended
with "dest_").

There are \code{(nrow(x))*(nrow(x)-1)} rows because for each observation, there
are \code{nrow(x)-1} other locations for it to be paired with (we are not
interested in the pairing of an observation with itself).

According to a similar logic, \code{origin_dest2} will output a dataframe of
dimensions \code{(nrow(x)*nrow(y))} by \code{(ncol(x) + ncol(y))}. Note that
if an observation appears on both the list of origins and destinations, the
pairing of an observation with itself will have to be manually removed if it
is not required.

Note that for \code{origin_dest2}, the choice or origin and destination
matters. The list being produced is a list of possible combinations of A
(origins) to B (destinations): the B to A combinations do not feature on the
list produced. A possible usage would be to find pairings between customers
and shops- the relevant shortest distance/drive time is that from the customer
address (origin) to the shop address (destination). The shortest
distance/drive time from the shop to the customer is unlikely to be of
interest.

If the B to A combinations are of interest though, the
\code{append_dest_origin} command can be used after \code{origin_dest2}. You
may want to sort your observations following the use of this command.
}
\usage{
origin_dest1(x)
origin_dest2(x, y)
append_dest_origin(x)
}
\arguments{
  \item{x}{dataframe to reshape; typically a list of locations. For
  \code{origin_dest2} this is a list of origins. For \code{append_dest_origin}
  this should be the output of \code{origin_dest2}.}
  \item{y}{applicable to \code{origin_dest2} only, this is a dataframe
  containing destination information.}}
\examples{
# Example 1 -------------------------------------------------------------------

# Finding all pairs of US states

library(origindest)

state.name <- as.data.frame(state.name)

origin.dest.list <- origin_dest1(state.name)


# Example 2 -------------------------------------------------------------------

# Finding pairs of US states beginning with "A" and all other states not
# beginning with A

library(origindest)

not.beginning.with.A <- filter(as.data.frame(state.name),
                               state.name != "Alabama" &
                               state.name != "Alaska" &
                               state.name != "Arizona" &
                               state.name != "Arkansas")

beginning.with.A <- filter(as.data.frame(state.name),
                           state.name == "Alabama" |
                           state.name == "Alaska" |
                           state.name == "Arizona" |
                           state.name == "Arkansas")

origin.dest.list <- origin_dest2(not.beginning.with.A, beginning.with.A)
}
