library(tmapverse)

tm_shape(World) +
	tm_polygons(
		fill = c("gender", "inequality"),
		fill.legend = tm_legend("")) +
	tm_crs("auto") +
	tm_layout(panel.labels = c("Gender inequality", "Economic inequality"))

tm_shape(World) +
	tm_polygons(
		fill = c("gender", "inequality"))


tm_shape(World) +
	tm_polygons(
		fill = c("blue", "#F4DD44"))

tm_shape(World) +
	tm_polygons(
		fill = c("gender", "inequality"),
		col = c("purple", "orange"),
		lwd = 3)

NLD_muni$pop_dens = NLD_muni$population / NLD_muni$area
tm_shape(NLD_muni) +
tm_polygons(
	fill = rep("pop_dens", 3),
	fill.scale = list(tm_scale_intervals(style = "pretty"),
					  tm_scale_intervals(style = "kmeans"),
					  tm_scale_intervals(style = "log10_pretty")),
	fill.legend = tm_legend("Population per km2")) +
	tm_layout(panel.labels = c("pretty", "kmeans", "log10_pretty"))

tm_shape(NLD_muni) +
	tm_polygons(
		fill = "pop_dens",
		fill.scale = list(tm_scale_intervals(style = "pretty"),
						  tm_scale_intervals(style = "kmeans"),
						  tm_scale_intervals(style = "log10_pretty")),
		fill.legend = tm_legend("Population per km2")) +
	tm_layout(panel.labels = c("pretty", "kmeans", "log10_pretty"))


tm_shape(NLD_muni) +
	tm_polygons("employment_rate") +
	tm_facets("province")


tm_shape(NLD_muni) +
	tm_polygons("employment_rate") +
	tm_facets("province", free.coords = FALSE)


tm_shape(NLD_muni) +
	tm_polygons("employment_rate") +
	tm_facets("province", free.coords = FALSE, drop.units = FALSE)


tm_shape(NLD_muni) +
	tm_polygons(fill = c("employment_rate", "dwelling_ownership")) +
	tm_facets("province")

tm = tm_shape(NLD_muni) +
	tm_polygons(fill = c("employment_rate", "dwelling_ownership")) +
	tm_facets("province", free.coords = TRUE) +
	tm_layout(scale = 0.3)

tmap_save(tm, filename = "small_mult.pdf", width = 2, height = 10)

tm2 = tm_shape(NLD_muni) +
	tm_polygons(fill = c("employment_rate", "dwelling_ownership")) +
	tm_facets_grid(columns = "province", free.coords = TRUE) +
	tm_layout(scale = 0.3)


tmap_save(tm2, filename = "small_mult2.pdf", width = 10, height = 2)


tm_shape(World) +
	tm_polygons(
		fill = "gender",
		fill.scale = tm_scale_intervals(values = "brewer.purples", value.na = "grey90"),
		fill.legend = tm_legend("Gender inequality")) +
	tm_symbols(
		size = "pop_est",
		fill = "inequality",
		fill.scale = tm_scale_intervals(values = "brewer.yl_or_br"),
		fill.legend = tm_legend("Economic inequality"),
		size.legend = tm_legend("Population")) +
	tm_crs("auto")

tm_shape(World) +
	tm_polygons(fill = "grey95") +
	tm_bubbles(
		fill = "red",
		size = "pop_est",
		fill.scale = tm_scale_continuous(
			values = "-matplotlib.rainbow",
			value.neutral = "gray70")) +
	tm_crs("auto")

tm_shape(World) +
	tm_polygons(fill = "grey95") +
	tm_bubbles(
		fill = "HPI",
		size = "pop_est",
		fill.scale = tm_scale_continuous(
			values = "-matplotlib.rainbow")) +
	tm_crs("auto")

tm_shape(World) +
	tm_polygons(fill = "grey95") +
	tm_bubbles(
		fill = "HPI",
		size = "pop_est",
		fill.scale = tm_scale_continuous(
			values = "-matplotlib.rainbow",
			value.neutral = "gray70")) +
	tm_crs("auto")


library(cols4all)
c4a_plot("pu_gn_bivs", n = 5)             # sequential x sequential

c4a_plot("brewer.qualseq", n = 3)          # sequential x categorical
c4a_plot("cols4all.bu_br_bivd", n = 5)     # sequential x diverging
c4a_plot("cols4all.yl_rd_bivg", n = 5)     # sequential x desaturation

tm_shape(World) +
	tm_polygons(
		fill = tm_vars(c("gender", "inequality"), multivariate = TRUE),
		fill.scale = tm_scale_bivariate(values = "+bu_br_bivs")) +
	tm_crs("auto")
