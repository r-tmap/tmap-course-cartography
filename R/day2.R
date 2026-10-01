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

# to illustrate multiple map values:
tm_shape(World) +
	tm_polygons(
		fill = c("blue", "#F4DD44"))

tm_shape(World) +
	tm_polygons(
		fill = c("gender", "inequality"),
		col = c("purple", "orange"),
		lwd = 3)

# three data variables (albeit the same variable) -> three maps, each with a different scale function
NLD_muni$pop_dens = NLD_muni$population / NLD_muni$area
tm_shape(NLD_muni) +
tm_polygons(
	fill = rep("pop_dens", 3),
	fill.scale = list(tm_scale_intervals(style = "pretty"),
					  tm_scale_intervals(style = "kmeans"),
					  tm_scale_intervals(style = "log10_pretty")),
	fill.legend = tm_legend("Population per km2")) +
	tm_layout(panel.labels = c("pretty", "kmeans", "log10_pretty"))

# one data variable -> just one map
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

# not a good map from a methodological point of view (color perception is tricky)
# aim is to show to options to use multiple map variables in the same map
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

# bivariate map
tm_shape(World) +
	tm_polygons(
		fill = tm_vars(c("gender", "inequality"), multivariate = TRUE),
		fill.scale = tm_scale_bivariate(values = "bu_br_bivs")) +
	tm_crs("auto")

# url to donut map
# https://dashboards.cbs.nl/v1/commutingNL/


## session 7 grid maps

library(geofacet)
nl_prov_grid1

tm_shape(NLD_prov) +
	tm_polygons() +
	tm_text("name")

setequal(nl_prov_grid1$name, NLD_prov$name)

setdiff(nl_prov_grid1$name, NLD_prov$name)
setdiff(nl_prov_grid1$name, NLD_prov$name)
nl_prov_grid1$name[nl_prov_grid1$name == "Friesland"] = "Fryslan"
setequal(nl_prov_grid1$name, NLD_prov$name)

data(NLD_prov)
NLD_prov = cbind(NLD_prov,
				 nl_prov_grid1[match(NLD_prov$name, nl_prov_grid1$name), ])

tm_shape(NLD_prov)

tm1 = tm_shape(NLD_prov) +
	tm_polygons() +
	tm_facets_grid(rows = "row", columns = "col")

tm2 = qtm(NLD_prov)

tmap_arrange(tm1, tm2)

# session 8: cartograms
tm_shape(World) +
	tm_polygons() +
	tm_grid()

tm_shape(World, crs = 4326) +
	tm_polygons()

tm_shape(World, crs = 3857) +
	tm_polygons()

tm_shape(World, crs = 3857) +
	tm_cartogram_ncont(size = "*area", options = opt_tm_cartogram_ncont(expansion = 0.15)) +
	tm_animate_fast(play = "pingpong")


tm_shape(World, crs = 3857) +
	tm_cartogram_ncont(size = "pop_est", options = opt_tm_cartogram_ncont(expansion = 0.15), fill = "gender")

Africa = World[World$continent == "Africa", ]

tm_shape(Africa, crs = "+proj=robin") +   # correct
	tm_cartogram(size = "pop_est") +
	tm_text("name", options = opt_tm_text(remove_overlap = TRUE))

tm_shape(Africa) +                         # wrong: transformation in lat/lon
	tm_cartogram(size = "pop_est") +
	tm_crs("+proj=robin")

tmap_mode("view")


tm1 = tm_shape(Africa, crs = "+proj=robin") +   # correct
	tm_cartogram(size = "pop_est") +
	tm_text("name", options = opt_tm_text(remove_overlap = TRUE)) +
	tm_basemap(NULL)

tm2 = tm_shape(Africa, crs = "+proj=robin") +   # correct
	tm_polygons() +
	tm_text("name", options = opt_tm_text(remove_overlap = TRUE)) +
	tm_basemap(NULL)
tmap_arrange(tm1, tm2, sync = TRUE)

# An interactive Dorling cartogram
tm_shape(World, crs = "+proj=robin") +
	tm_cartogram_dorling(
		hover = "name",
		size = "pop_est",
		fill = "press",
		fill.scale = tm_scale_continuous(values = "cols4all.pu_gn_div", midpoint = 50),
		fill.legend = tm_legend("", height = 30)) +
	tm_title("World Press Freedom Index") +
	tm_basemap(NULL)

tmap_mode("plot")

tm_shape(NLD_muni) +
	tm_cartogram(size = "population")

tm_shape(World) +
	tm_cartogram(size = "pop_est")
