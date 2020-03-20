# Nightingale-Visualization

The Nightingale dataset contains the information about different causes of death in the army in the East. The code initially takes this dataset and divides it into two smaller datasets based on the criteria of whether the date of the death in data  is before or after 1st April 1855.
Based on the subsets obtained above, Figure 1 is plotted with data from April 1854 to march 1855 with different colours representing the different causes of death i.e.  Preventible or Mutigable Zymotic diseases or wounds or other causes.
Functions like “ggplot” and “coord_polar” are being used to plot the information with fill= Cause of death,
Figure 2 is also plotted with similar functions but it is also repositioned, rotated and zoomed with the help of setting the direction= -1 inside coord_polar and setting the value of zoom with “ggplot_build”. The Figure 2 represents the causes of deaths from April 1855 to March 1856.
