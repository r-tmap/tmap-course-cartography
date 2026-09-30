library(tmapverse)

World

tm_shape(World) +
	tm_polygons()

tm_shape(World) +
	tm_polygons(fill = "well_being")

tmap_mode("view")

tm_shape(World) +
	tm_polygons(fill = "well_being")



tm_shape(World) +
	tm_polygons(fill = "well_being") +
	tm_credits("Natural Earth Data")

tmap_mode("plot")

tm_shape(World) +
	tm_polygons(fill = "well_being")

names(World)

tm_shape(World) +
	tm_polygons(fill = "pink",
				lwd = "well_being",
				lwd.scale = tm_scale_continuous(values.scale = 3),
				col = "well_being") +
	tm_text("name", options = opt_tm_text(remove_overlap = TRUE))

st_crs(World)

tm_shape(World) +
	tm_polygons(fill = "well_being")

tmap_mode("plot")

tm_shape(World) +
	tm_polygons(fill = "well_being") +
	tm_crs("+proj=eck4")

tm_shape(World) +
	tm_polygons(fill = "well_being") +
	tm_crs("+proj=eqearth")


tmap_mode("maplibre")

tm_shape(World) +
	tm_polygons(fill = "well_being")

tmap_style("cobalt")

tm_shape(World) +
	tm_polygons(fill = "well_being")

tm_shape(World) +
	tm_polygons(fill = "well_being") +
	tm_layout(outer.margins = 0, asp = 0)


tm_shape(World) +
	tm_polygons("HPI",
				fill.scale = tm_scale_intervals(style = "sd"))


