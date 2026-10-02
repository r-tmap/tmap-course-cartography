library(tmapverse)
library(tmaptools)

tm_shape(NLD_muni) +
	tm_polygons(fill = "edu_appl_sci") +
	tm_title("Population share with (applied) university degree in 2022") +
	tm_credits("Statistics Netherlands (CBS)") +
	tm_minimap(position = c("left", "top"))

Africa = World[World$continent == "Africa",]
tm_shape(World) +
	tm_fill(fill = "gray85") +
tm_shape(Africa, is.main = TRUE) +
	tm_polygons(fill = "well_being") +
	tm_minimap(position = c("left", "bottom"), width = 10, height = 10)

globe = tm_shape(World) +
	tm_polygons() +
	tm_crs(bbox = "FULL", "+proj=ortho +lat_0=30 +lon_0=0") +
	tm_layout(earth_boundary = TRUE)

# bug
tm_shape(World) +
	tm_fill(fill = "gray85") +
	tm_shape(Africa, is.main = TRUE) +
	tm_polygons(fill = "well_being") +
	tm_inset(globe, width = 10, height = 10)



# sf: vectors
# stars: raster data (also irregular)
str(st_bbox(NLD_prov))

# terra: raster data (regular) and vectors
terra::ext(NLD_prov)


tm_shape(NLD_dist) +
	tm_fill(fill = "income_high",
			fill.legend = tm_legend("High income (%)", group_id = "A", z = 2)) +
tm_shape(NLD_muni) +
	tm_borders(lwd = 1, col = "black") +
	tm_inset(tmaptools::bb("Utrecht", ext = 1.4), group_id = "A", z = 1) +
	tm_title("Utrecht", group_id = "A", z = 0) +
	tm_components(group_id = "A", position = tm_pos_in("left", "top"), frame = FALSE, bg = FALSE)

EU = World[World$continent == "Europe" & World$name != "Russia", ]
bb_eu = sf::st_bbox(c(xmin = 2500000, ymin = 1400000,
					  xmax = 6500000, ymax = 5400000), crs = 3035)

tm_iceland = tm_shape(World[World$name == "Iceland", ], crs = 3035) +
	tm_polygons("well_being",
				fill.scale = tm_scale_intervals(breaks = 4:8, values = "brewer.yl_gn_bu"),
				fill.legend = tm_legend_hide()) +
	tm_layout(frame = FALSE)

tm_shape(EU, crs = 3035, bbox = bb_eu) +
	tm_polygons("well_being",
				fill.scale = tm_scale_intervals(breaks = 4:8, values = "brewer.yl_gn_bu"),
				fill.legend = tm_legend("Well-being")) +
	tm_inset(tm_iceland, position = c("left", "top"), height = 6, width = 8)




library(ggplot2)
tm_shape(NLD_muni) +
	tm_polygons("edu_appl_sci",
				fill.legend = tm_legend("University degree"),
				fill.chart = tm_chart_bar())


library(ggplot2)
tm_shape(NLD_muni) +
	tm_polygons("edu_appl_sci",
				fill.legend = tm_legend("University degree"),
				fill.chart = tm_chart_bar(extra.ggplot2 = theme(panel.grid.major.y = element_line(colour = "red"))))


gg = ggplot(NLD_muni, mapping = aes(x = income_high, y = edu_appl_sci)) + geom_point() + theme_minimal(base_size = 8) + labs(x = "High income", y = "High education")

library(ggplot2)
tm_shape(NLD_muni) +
	tm_polygons("edu_appl_sci",
				fill.legend = tm_legend("University degree", group_id = "A")) +
	tm_inset(gg, group_id = "A") +
	tm_components(group_id = "A", tm_pos_out("right", "center"))


tm_shape(NLD_muni) +
	tm_polygons("edu_appl_sci",
				fill.legend = tm_legend("University degree", group_id = "A")) +
	tm_inset(gg, group_id = "A") +
	tm_components(group_id = "A", tm_pos_out("right", "center"), frame_combine = FALSE)

tm_shape(NLD_muni) +
	tm_polygons("edu_appl_sci",
				fill.legend = tm_legend("University degree", group_id = "A")) +
	tm_inset(gg, group_id = "A") +
	tm_components(group_id = "A", tm_pos_out("center", "bottom"), frame_combine = FALSE, stack = "horizontal")

tm_shape(NLD_muni) +
	tm_polygons("edu_appl_sci",
				fill.legend = tm_legend("University degree", group_id = "A")) +
	tm_inset(gg, group_id = "A") +
	tm_components(group_id = "A", tm_pos_out("center", "bottom"), frame_combine = FALSE, stack = "horizontal")

tm_shape(NLD_muni) +
	tm_polygons("edu_appl_sci",
				fill.legend = tm_legend("University degree", group_id = "A")) +
	tm_inset(gg, group_id = "A") +
	tm_components(group_id = "A", tm_pos_out("center", "bottom"), frame_combine = FALSE, stack = "horizontal", stack_margin = 0.1, offset = 0)

data(land)
tm_shape(land) +
	tm_raster("elevation")


note = grid::gList(
	grid::rectGrob(gp = grid::gpar(fill = "gold", col = NA)),
	grid::textGrob("Extremely urbanised\nmunicipalities",
				   gp = grid::gpar(fontsize = 9)))

grid::grid.draw(note)


tmap_design_mode(TRUE)


bb_Randstad = bb("Leiden", width = 3, height = 2, relative = TRUE)
tm_shape(NLD_muni) +
	tm_polygons("grey95", col = "grey70") +
	tm_shape(NLD_muni[NLD_muni$urbanity == "extremely urbanised", ]) +
	tm_polygons("darkorange") +
	tm_inset(note, position = c("left", "top"), height = 4, width = 8) +
	tm_inset(bb_Randstad, position = c("left", "top"), height = 4, width = 8,
			 box_frame.color = "darkorange", main_frame.color = "darkorange")

tmap_design_mode(FALSE)



# session 11: networks
library(sfnetworks)
sfn = as_sfnetwork(roxel)
class(sfn)

plot(sfn)
?roxel

tm_shape(sfn) +
	tm_edges() +
	tm_nodes() +
	tm_minimap()

tmap_mode("view")


tm_shape(sfn) +
	tm_edges(col = "type", lwd = 4) +
	tm_nodes()


library(tidygraph)
sfn2 = sfn |>
	activate("nodes") |>
	mutate(degree = centrality_degree(mode = "all"))

tm_shape(sfn2) +
	tm_edges(col = "grey60", lwd = 2) +
	tm_nodes(fill = "degree", size = 0.6,
			 fill.scale = tm_scale_categorical(values = "brewer.yl_or_rd"),
			 fill.legend = tm_legend("Degree"))

sfn |>
	activate("edges") |> mutate(test = 1)

sfn |>
   activate("nodes") |> mutate(test = 1)


# Session 12: basemaps

tmap_overview()

tmap_mode("plot")

tm_shape(NLD_muni) +
	tm_polygons("dwelling_value")

rtm()

tm_shape(NLD_muni) +
	tm_polygons("dwelling_value")

rtm()

tm_shape(NLD_muni) +
	tm_polygons("dwelling_value")

# global datasets in tmap:
# World
# land
# metro
# World_rivers


tm_shape(metro) +
	tm_bubbles(size = "pop2020") +
	tm_basemap("OpenTopoMap")

tm_shape(World_rivers) +
	tm_lines(lwd = "strokelwd",
			 col = "steelblue",
			 lwd.scale = tm_scale_continuous(values.scale = 3))


tmap_providers()

tmap_mode("plot")

tmap_providers()

World_land = st_union(World)
plot(World_land)

tm_shape(World_land) +
	tm_borders(col = "black") +
tm_shape(World_rivers, is.main = TRUE) +
	tm_lines(lwd = "strokelwd",
			 col = "steelblue",
			 lwd.scale = tm_scale_continuous(values.scale = 3)) +
tm_basemap("Esri.WorldGrayCanvas") +
	tm_crs("+proj=robin")

# alternative without basemap
tm_shape(World_land) +
	tm_polygons(fill = "white", col = "black") +
	tm_shape(World_rivers, is.main = TRUE) +
	tm_lines(lwd = "strokelwd",
			 col = "steelblue",
			 lwd.scale = tm_scale_continuous(values.scale = 3)) +
	tm_basemap("Esri.WorldGrayCanvas") +
	tm_crs("+proj=robin") +
	tm_layout(bg.color = "grey85")


tmap_mode("view")

tm_shape(NLD_prov) +
	tm_borders(lwd = 2) +
	tm_basemap("CyclOSM")


# demo of layer blending

# ordering of layers: by order in the plot call
tmap_mode("plot")
tm_shape(metro) +
	tm_bubbles(size = "pop2020", fill = 'red') +
	tm_shape(World) +
	tm_polygons(fill = "footprint")

# unless zindex is used...
tmap_mode("plot")
tm_shape(metro) +
	tm_bubbles(size = "pop2020", fill = 'red', zindex = 402) +
tm_shape(World) +
	tm_polygons(fill = "footprint", zindex = 401)

#
tmap_mode("plot")
tm_shape(metro) +
	tm_bubbles(size = "pop2020", fill = 'red') +
	tm_shape(World) +
	tm_polygons(fill = "footprint", blend = "multiply")

tm_shape(metro) +
	tm_bubbles(size = "pop2020", fill = 'red') +
	tm_shape(World) +
	tm_polygons(fill = "footprint", blend = "overlay")

tm_shape(NLD_muni) +
	tm_polygons("income_high",
				fill.scale = tm_scale_intervals(values = "brewer.purples"),
				col = NULL) +
	tm_tiles("CartoDB.PositronOnlyLabels")

