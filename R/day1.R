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

# toy example to illustrate that not used polygon fill can be used to show data variables
tm_shape(World) +
	tm_polygons(fill = "pink",
				lwd = "well_being",
				lwd.scale = tm_scale_continuous(values.scale = 3),
				col = "well_being") +
	tm_text("name", options = opt_tm_text(remove_overlap = TRUE))

# map projection (coordinate reference system) of the World dataset:
st_crs(World)

tm_shape(World) +
	tm_polygons(fill = "well_being")

tmap_mode("plot")

# shown areas are now proportional to real world areas
tm_shape(World) +
	tm_polygons(fill = "well_being") +
	tm_crs("+proj=eck4")

tm_shape(World) +
	tm_polygons(fill = "well_being") +
	tm_crs("+proj=eqearth")

# just to show how big Africa is:
tmap_mode("maplibre")
tm_shape(World) +
	tm_polygons(fill = "well_being")

tmap_mode("plot")
tmap_style("cobalt")

tm_shape(World) +
	tm_polygons(fill = "well_being")

# to make sure the frame occupies the whole device
tm_shape(World) +
	tm_polygons(fill = "well_being") +
	tm_layout(outer.margins = 0, asp = 0)


tm_shape(World) +
	tm_polygons("HPI",
				fill.scale = tm_scale_intervals(style = "sd"))

# example of a manual legend
tm_shape(NLD_prov) +
	tm_polygons("grey90", col = "grey50") +
	tm_shape(NLD_muni[NLD_muni$population > 150000, ]) +
	tm_dots(fill = "red", size = 0.5) +
	tm_add_legend(
		type = "symbols",
		title = "",
		fill = "red",
		labels = "Municipality with > 150,000 inhabitants")

# alternative: use data variable
NLD_muni$is_large = NLD_muni$population > 150000
tm_shape(NLD_prov) +
	tm_polygons("grey90", col = "grey50") +
	tm_shape(NLD_muni) +
	tm_dots(fill = "is_large",
			size = "is_large",
			size.scale = tm_scale_categorical(values = c(0, 0.5), labels = c("", "Municipality with > 150,000 inhabitants")),
			fill.scale = tm_scale_categorical(values = c("grey90", "red")),
			fill.legend = tm_legend_combine("size"),
			size.legend = tm_legend(title = "")) +
	tm_add_legend(
		type = "symbols",
		title = "",
		size = 0.6,
		col = NA,
		fill = "red",
		labels = "Municipality with > 150,000 inhabitants")

tm_shape(NLD_prov) +
	tm_polygons("grey90", col = "grey50") +
	tm_shape(NLD_muni) +
	tm_dots(fill = "is_large",
			size = "is_large",
			size.scale = tm_scale_categorical(values = c(0, 0.5), labels = c("", "Municipality with > 150,000 inhabitants")),
			fill.scale = tm_scale_categorical(values = c("grey90", "red")),
			fill.legend = tm_legend_hide(),
			size.legend = tm_legend_hide()) +
	tm_add_legend(
		type = "symbols",
		title = "",
		size = 0.6,
		col = NA,
		fill = "red",
		labels = "Municipality with > 150,000 inhabitants")

tmap_style("white")

tmap_design_mode()

# cols4all
library(cols4all)
c4a_gui()

tableau.classic10



tm_shape(World) +
	tm_polygons(fill = "well_being",
				fill.scale = tm_scale(values = "tableau.classic10"))


c4a("brewer.blues", n = 90, range = c(0.5, 1)) |> c4a_plot()

c4a_palettes(type = "seq", series = "powerbi")


c4a("brewer.blues", n = 10) |> c4a_plot(include.cvd = TRUE)

c4a("brewer.set2", n = 8) |> c4a_plot(include.cvd = TRUE)

tm_shape(World) +
	tm_polygons(fill = "well_being", fill.scale = tm_scale_continuous(values = .P$cols4all$div$bu_br_div)) +
	tm_layout(color_vision_deficiency_sim = "tritan")

# plot the map in 3 color blind type simulations
lapply(c("none", "deutan", "protan", "tritan"), FUN = function(cvd) {
	tm_shape(World) +
		tm_polygons(fill = "well_being", fill.scale = tm_scale_continuous(values = "brewer.rd_yl_gn")) +
		tm_layout(color_vision_deficiency_sim = cvd) +
		tm_title_in(cvd)
}) |> tmap_arrange()


# experimenting with different color palettes:

tm_shape(NLD_dist) +
	tm_fill("edu_appl_sci", fill.scale = tm_scale_intervals(values = "brewer.blues")) +
	tm_shape(NLD_muni) +
	tm_borders(col = "black") +
	tm_shape(NLD_prov) +
	tm_borders(lwd = 2, "black")

# does not work well (imho):
tm_shape(NLD_dist) +
	tm_fill("edu_appl_sci", fill.scale = tm_scale_intervals(values = "hcl.dark2")) +
	tm_shape(NLD_muni) +
	tm_borders(col = "black") +
	tm_shape(NLD_prov) +
	tm_borders(lwd = 2, "black")

# works very well:
tm_shape(NLD_dist) +
	tm_fill("edu_appl_sci", fill.scale = tm_scale_intervals(values = "matplotlib.plasma")) +
	tm_shape(NLD_muni) +
	tm_borders(col = "black") +
	tm_shape(NLD_prov) +
	tm_borders(lwd = 2, "black")

# analyse your own palette:
c4a_data(list(mypal1 = c("red", "purple", "orange", "darkorange", "blue", "#44FED4")),
		 type = "cat",
		 series = "mypals") |> c4a_load()

c4a_gui()
