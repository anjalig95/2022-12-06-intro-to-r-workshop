# # Visualising data with ggplot2

# Based on: https://datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Plotting with ggplot2
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# load ggplot
#library(ggplot2) #this is included in tidyverse
library(tidyverse)

# load data

surveys_complete <- read_csv("data_out/surveys_complete.csv")

# empty plot

ggplot(data = surveys_complete)
  

# empty plot with axes

ggplot(surveys_complete, aes(weight, hindfoot_length)) 

# data appears on the plot

ggplot(surveys_complete, aes(weight, hindfoot_length)) +
  geom_point()


# assign a plot to an object

splot <- ggplot(surveys_complete, aes(weight, hindfoot_length)) 
splot

# display the ggplot object (plus add an extra geom layer)

splot +  
  geom_point()



# ------------------------
# Exercise/Challenge 1
# ------------------------
# Change the mappings so weight is on the y-axis and hindfoot_length is on the x-axis


ggplot(surveys_complete, aes(hindfoot_length, weight)) +
  geom_point()

ggplot(surveys_complete, aes(weight)) +
  geom_histogram(binwidth = 10)

install.packages("hexbin")  # gives a count of the data points in addition to the actual plot
library(hexbin)

splot + geom_hex()


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Building plots iteratively
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 


splot +
  geom_point(alpha = 0.2, size = 2, colour = 123)

splot +
  geom_point(alpha = 0.2, aes(colour = species_id))



# ------------------------
# Exercise/Challenge 2
# ------------------------
#
# Use what you just learned to create a scatter plot of weight over species_id 
# with the plot type showing in different colours. 
# Is this a good way to show this type of data?

ggplot(surveys_complete, aes(species_id, weight)) +
  geom_point(aes(colour = plot_id))

ggplot(surveys_complete, aes(species_id, weight)) +
  geom_jitter(position = "jitter", aes(colour = plot_id))


#not a great way to display this data...





# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Boxplots
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#

# one discrete, one continuous variable




# ------------------------
# Exercise/Challenge 3
# ------------------------

# Notice how the boxplot layer is behind the jitter layer? What do you need to change in the code to put the boxplot in front of the points such that it's not hidden?

ggplot(surveys_complete, aes(species_id, weight)) +
  geom_boxplot()

ggplot(surveys_complete, aes(species_id, weight)) +
  geom_jitter(alpha = 0.3, position = "jitter", colour = "tomato") +
  geom_boxplot(alpha = 0)



# ------------------------
# Exercise/Challenge 4
# ------------------------

# Boxplots are useful summaries but hide the shape of the distribution. 
# For example, if there is a bimodal distribution, it would not be observed 
# with a boxplot. An alternative to the boxplot is the violin plot 
# (sometimes known as a beanplot), where the shape (of the density of points) 
# is drawn.
# 
#Replace the box plot with a violin plot

ggplot(surveys_complete, aes(species_id, weight)) +
  geom_jitter(alpha = 0.3, position = "jitter", colour = "tomato") +
  geom_violin(alpha = 0)



# ------------------------
# Exercise/Challenge 5
# ------------------------

# So far, we've looked at the distribution of weight within species. Make a new 
# plot to explore the distribution of hindfoot_length within each species.
# Add color to the data points on your boxplot according to the plot from which 
# the sample was taken (plot_id).

# Hint: Check the class for plot_id. Consider changing the class of plot_id from 
# integer to factor. How and why does this change how R makes the graph?

# with a color scale

surveys_complete$plot_id <- as.factor(surveys_complete$plot_id)

ggplot(surveys_complete, aes(species, hindfoot_length)) +
  geom_jitter(alpha = 0.3, position = "jitter", aes(colour = plot_id)) +
  geom_boxplot(alpha = 0)


#now run again, and there are discrete colors:


# alternately, we can change the class of plot_id on the fly (without changing data object)

ggplot(surveys_complete, aes(species, hindfoot_length)) +
  geom_jitter(alpha = 0.3, position = "jitter", aes(colour = as.factor(plot_id))) +
  geom_boxplot(alpha = 0)



# ------------------------
# Exercise/Challenge 6
# ------------------------

# In many types of data, it is important to consider the scale of the 
# observations. For example, it may be worth changing the scale of the axis to 
# better distribute the observations in the space of the plot. Changing the scale
# of the axes is done similarly to adding/modifying other components (i.e., by 
# incrementally adding commands). 
# Make a scatter plot of species_id on the x-axis and weight on the y-axis with 
# a log10 scale.

ggplot(surveys_complete, aes(species, weight)) +
  geom_jitter(alpha = 0.3, position = "jitter", aes(colour = as.factor(plot_id))) +
  geom_boxplot(alpha = 0) +
  scale_y_log10()



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Plotting time series data
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 

# counts per year for each genus

year_counts <- surveys_complete %>%
  count(year, genus)

ggplot(year_counts, aes(year, n, group = genus)) +
  geom_line()
  

# ------------------------
# Exercise/Challenge 7
# ------------------------
# Modify the code for the yearly counts to colour by genus so we can clearly see the counts by genus. 

ggplot(year_counts, aes(year, n, colour = genus)) +
  geom_line()



# OR alternately
# integrating the pipe operator with ggplot (no need to make a separate dataframe)

surveys_complete %>%
  count(year, genus) %>%
  ggplot(aes(year, n, colour = genus)) +
  geom_line() +
  labs(title = "Counts of each genus over time",
         x = "Year",
         y = "Number of observations")

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Faceting
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Split one plot into Multiple plots

ggplot(year_counts, aes(year, n, colour = genus)) +
  geom_line() +
  facet_wrap(~ genus)

ggplot(year_counts, aes(year, n, colour = genus)) +
  geom_line() +
  facet_wrap(facets = var(genus))



# organise rows and cols to show sex and genus

year_sex <- surveys_complete %>%
  count(year, sex, genus)

ggplot(year_sex, aes(year, n, colour = sex)) +
  geom_line() +
  facet_wrap(~ genus)

surveys_complete %>%
  count(year, sex, genus) %>%
  ggplot(year_sex, aes(year, n, colour = sex)) +
  geom_line() +
  facet_wrap(~ genus)
  

# organise rows by genus only
 
ggplot(year_sex, aes(year, n, colour = sex)) +
  geom_line() +
  facet_grid(row = vars(sex), col = vars(genus))

ggplot(year_sex, aes(year, n, colour = sex)) +
  geom_line() +
  facet_grid(row = vars(genus))
  
# ------------------------
# Exercise/Challenge 8
# ------------------------
# How would you modify this code so the faceting is organised into only columns 
# instead of only rows?

ggplot(year_sex, aes(year, n, colour = sex)) +
  geom_line() +
  facet_grid(col = vars(genus))

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Themes
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# themes set a look

ggplot(year_sex, aes(year, n, colour = sex)) +
  geom_line() +
  facet_wrap(~ genus) +
  theme_bw()

ggplot(year_sex, aes(year, n, colour = sex)) +
  geom_line() +
  facet_wrap(~ genus) +
  theme_linedraw()

# ------------------------
# Exercise/Challenge 9
# ------------------------
# Put together what you've learned to create a plot that depicts how the average 
# weight of each species changes through the years.
# Hint: need to do a group_by() and summarize() to get the data before plotting

yearly_weight <- surveys_complete %>%
  group_by(species, year) %>%
  summarize(mean_weight = mean(weight))

ggplot(yearly_weight, aes(year, mean_weight, colour = species)) +
  geom_line() +
  theme_bw()

ggplot(yearly_weight, aes(year, mean_weight)) +
  geom_line() +
  facet_wrap(~ species) +
  theme_bw()


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Customisation
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Makinging it your own

year_sex <- surveys_complete %>%
  count(year, sex, genus)

my_plot <- ggplot(year_sex, aes(year, n, colour = sex)) +
  geom_line(size = 1) +
  facet_wrap(~ genus) +
  labs(title = "Observed genera through time", 
       x = "Year of observations", 
       y = "Number of individuals") +
  theme_classic() +
  theme(text = element_text(size = 16))

# save theme configuration as an object



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Exporting plots
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ggsave("figures/my_plot.pdf", my_plot, width = 15, height = 10)

