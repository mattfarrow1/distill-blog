# Create site logo

# Setup -------------------------------------------------------------------
library(ggplot2)
library(showtext)
library(triangular)
library(LaCroixColoR)

# Generate Triangular Logo ------------------------------------------------

# credit: https://github.com/coolbutuseless/triangular

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# polygons_df - data.frame of polygon vertices with group/subgroups
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
r <- 5
hex_df <- data.frame(
  x = r * cos(seq(30, 360, 60) * pi/180),
  y = r * sin(seq(30, 360, 60) * pi/180),
  group = 1,
  subgroup = 1
)

hole_df <- data.frame(
  x = 2 * cos(seq(30, 360, 60) * pi/180) + 1,
  y = 2 * sin(seq(30, 360, 60) * pi/180) + 1,
  group    = 1,
  subgroup = 2
)

polygons_df <- rbind(hex_df, hole_df)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Turn the polygon data.frame into individual triangles
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
triangles_df <- triangular::decompose(polygons_df)

# Load Google Fonts -------------------------------------------------------

# credit: https://cran.rstudio.com/web/packages/showtext/vignettes/introduction.html
# install.packages("showtext")

# credit: https://stackoverflow.com/questions/34522732/changing-fonts-in-ggplot2
library(showtext)

# Loading Google fonts (https://fonts.google.com/)
# font_add_google("Long Cang", "draft")
# font_add_google("Kavivanar", "draft")
# font_add_google("Dekko", "draft")
# font_add_google("Shadows Into Light Two", "draft")
font_add_google("East Sea Dokdo", "draft")

# to get over issues mentioned at https://cran.rstudio.com/web/packages/showtext/vignettes/introduction.html
quartz()

# Automatically use showtext to render text
showtext_auto()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Plot the triangles
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

ggplot(triangles_df) +
  geom_polygon(aes(x, y, fill = as.factor(idx)), colour = 'grey20', size = 0.15) +
  theme_void() + 
  coord_equal() + 
  theme(legend.position = 'none') + 
  # scale_fill_viridis_d(option = 'D') + 
  scale_fill_manual(values = lacroix_palette("Pamplemousse", n = 12, type = "continuous")) +
  annotate('text', x = 1, y = 1.45, label = 'MATT', size = 14, family = 'draft') +
  annotate('text', x = 1, y = 0.55, label = 'FARROW', size = 14, family = 'draft')

ggsave("images/logo.png", width = 5, height = 5)
