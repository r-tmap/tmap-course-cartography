## Helper functions to prepare the Dutch commuting data (session 11)
## Data: Statistics Netherlands (CBS), 2024

library(dplyr)
library(tidyr)
library(sf)
library(sfnetworks)

# Classify municipality codes into highlighted municipalities, "home" or "other"
#   x              : vector of municipality codes to classify
#   ref            : reference codes (same length as x), used to flag self-flows as "home"
#   lvls           : factor levels of the result
#   code_highlight : codes of the highlighted municipalities
#   name_highlight : names corresponding to code_highlight
categorise = function(x, ref = NULL, lvls, code_highlight, name_highlight) {
	if (is.null(ref)) ref = rep(NA_integer_, length(x))
	factor(
		case_when(
			x %in% code_highlight ~ name_highlight[match(x, code_highlight)],
			x == ref              ~ "home",
			TRUE                  ~ "other"
		),
		levels = lvls
	)
}

# Aggregate OD flows per node: one row per node with one column per donut
# category (highlighted municipalities, "other", "home_part"), the Total,
# and home (the self-flow, for popups)
aggregate_od = function(flows, group_col, cat_col, code_highlight, name_highlight) {
	donut_levels = c(name_highlight, "other", "home")
	flows |>
		mutate(
			to_cat   = categorise(to,   ref = from, lvls = donut_levels,
								  code_highlight = code_highlight, name_highlight = name_highlight),
			from_cat = categorise(from, ref = to,   lvls = donut_levels,
								  code_highlight = code_highlight, name_highlight = name_highlight)
		) |>
		group_by(across(all_of(c(group_col, cat_col)))) |>
		reframe(jobs = round(sum(jobs))) |>
		pivot_wider(id_cols = all_of(group_col), names_from = all_of(cat_col), values_from = "jobs") |>
		mutate(across(everything(), \(x) replace_na(x, 0))) |>
		rename(home_part = home) |>
		left_join(flows |> group_by(across(all_of(group_col))) |> reframe(Total = round(sum(jobs))),
				  by = group_col) |>
		left_join(flows |> dplyr::filter(to == from) |> group_by(across(all_of(group_col))) |>
				  	reframe(home = round(sum(jobs))),
				  by = group_col) |>
		mutate(home = coalesce(home, home_part))
}

# Build the network: municipality nodes (with aggregated job data) and
# edges (commuter flows of at least edge_min jobs), flow = "jobs" (where do
# workers come from?) or "residents" (where do residents work?)
build_network = function(od, muni_point, name_highlight, flow = "jobs", edge_min = 500) {
	code_highlight = muni_point$code[match(name_highlight, muni_point$name)]
	join_col = if (flow == "residents") "from" else "to"

	od_nodes = if (flow == "residents") {
		aggregate_od(od, "from", "to_cat", code_highlight, name_highlight)
	} else {
		aggregate_od(od, "to", "from_cat", code_highlight, name_highlight)
	}

	od_edges = od |>
		mutate(
			to_cat   = categorise(to,   lvls = c(name_highlight, "other"),
								  code_highlight = code_highlight, name_highlight = name_highlight),
			from_cat = categorise(from, lvls = c(name_highlight, "other"),
								  code_highlight = code_highlight, name_highlight = name_highlight),
			label    = paste(muni_point$name[match(from, muni_point$code)],
							 muni_point$name[match(to,   muni_point$code)], sep = " to "),
			Jobs     = round(jobs),
			from_idx = match(from, muni_point$code),
			to_idx   = match(to,   muni_point$code)
		) |>
		select(-from, -to) |>
		rename(from = from_idx, to = to_idx)

	net = sfnetwork(nodes = muni_point, edges = od_edges, directed = TRUE, node_key = "code") |>
		activate("edges") |>
		sfnetworks::to_spatial_explicit()

	net[[1]] |>
		dplyr::filter(from != to, jobs >= edge_min) |>
		activate("nodes") |>
		left_join(od_nodes, by = c("code" = join_col))
}
