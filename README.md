# origindest - Reshape data into origin-destination pairs
Requires dplyr and tidyr packages from tidyverse to be
installed, origin_dest1 takes as its only argument x a dataframe
(presumably containing information about locations) and outputs a dataframe
containing all possible origin-destination pairings between the observations
in the dataframe. A typical usage of this function would be to get a dataframe
prepared for the subsequent calculation of distances or drive times between
locations.
origin_dest2 instead takes two arguments/dataframes, one containing the
origins x and the other containing the destinations y.
