# These are examples of randomColors in action

library(Cairo)
library(igraph)
library(randomcoloR)

k <- 200

CairoPNG("demo/graph1.png")
plot(erdos.renyi.game(k, 0.1), vertex.label=NA,
     edge.lty="blank", vertex.color=randomColor(k))
dev.off()

CairoPNG("demo/graph2.png")
plot(erdos.renyi.game(k, 0.1), vertex.label=NA,
     edge.lty="blank", vertex.color=randomColor(k, hue="red"))
dev.off()

CairoPNG("demo/graph3.png")
plot(erdos.renyi.game(k, 0.1), vertex.label=NA,
     edge.lty="blank", vertex.color=randomColor(k, luminosity="light"))
dev.off()


library(dplyr)
library(ggplot2)
library(maps)

states_map <- map_data("state")

# Using the default ggplot scheme, many similar colors for states
ggplot(states_map, aes(x=long, y=lat, group=group)) +
  geom_polygon(aes(fill=region), color="black") +
  guides(fill=FALSE)
ggsave("demo/map1.png", device="png", width=7, height=4)

# Instead, let's find the most distinctive set of colors for all states
# Which state is pink below?
s <- unique(states_map$region)
df <- data.frame(region=s, newColor=distinctColorPalette(length(s)),
                 stringsAsFactors=FALSE)
states_map <- left_join(states_map, df, by="region")

# Now, which state is pink below? The colors are more optically distinct now.
ggplot(states_map, aes(x=long, y=lat, group=group)) +
  geom_polygon(fill=states_map$newColor, color="black")
ggsave("demo/map2.png", device="png", width=7, height=4)
