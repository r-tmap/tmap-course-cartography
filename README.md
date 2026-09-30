# Advanced Static Cartography

Go beyond basic choropleths: learn to make publication-quality static maps in R that communicate complex spatial patterns.

This course uses **tmap** as the central mapping framework, combined with specialized extensions and supporting packages.

**Map types**

- Bivariate choropleths and multivariate maps
- Glyph maps (donut maps, flower maps) with **tmap.glyphs**
- Grid maps with **geofacet** and **gridmappr**
- Cartograms (contiguous, non-contiguous, Dorling) with **tmap.cartogram**
- Network maps with **sfnetworks** and **tmap.networks**

**Cartographic design**

- Effective, color-blind friendly color palettes with **cols4all**
- Insets: inset maps, inset charts and custom elements
- Choosing appropriate basemaps
- Visual hierarchy and final map polish

By the end of the course, you will be able to design clear, visually compelling maps that are ready for publication.

### Course URLs


[PR Stats](https://prstats.org/course/advanced-static-cartography-ascr01/)



## Schedule


| | New York (EDT) | London (BST) | Amsterdam (CEST) |
|:--------------|:---------------|:-------------|:-----------------|
| Session | 09:15–10:05 | 14:15–15:05 | 15:15–16:05 |
| Short Break | 10:05–10:25 | 15:05–15:25 | 16:05–16:25 |
| Session | 10:25–11:15 | 15:25–16:15 | 16:25–17:15 |
| --- | --- | --- | --- |
| Long Break | 11:15–13:15 | 16:15–18:15 | 17:15–19:15 |
| --- | --- | --- | --- |
| Session | 13:15–14:05 | 18:15–19:05 | 19:15–20:05 |
| Short Break | 14:05–14:25 | 19:05–19:25 | 20:05–20:25 |
| Session | 14:25–15:15 | 19:25–20:15 | 20:25–21:15 |

## Sessions

Day 1 (Wednesday 30th of September)

1. Introduction and overview  [Slides](https://10mapz.com/tmap_course_cartography/session_01_intro.html)
2. Designing effective thematic maps [Slides](https://10mapz.com/tmap_course_cartography/session_02_design.html)
3. Color palettes <!-- [Slides](https://10mapz.com/tmap_course_cartography/session_03_colors.html) -->
4. Bivariate choropleths and multivariate mapping <!-- [Slides](https://10mapz.com/tmap_course_cartography/session_04_bivariate.html) -->

<!-- [Day 1 exercises](https://10mapz.com/tmap_course_cartography/tmap_course_cartography_ex_day1.html) -->
<!-- [Day 1 solutions](https://10mapz.com/tmap_course_cartography/tmap_course_cartography_ex_day1_solutions.html) -->

Day 2 (Thursday 1st of October)

5. Review of exercises
6. Glyph maps <!-- [Slides](https://10mapz.com/tmap_course_cartography/session_06_glyphs.html) -->
7. Grid maps <!-- [Slides](https://10mapz.com/tmap_course_cartography/session_07_gridmaps.html) -->
8. Cartograms <!-- [Slides](https://10mapz.com/tmap_course_cartography/session_08_cartograms.html) -->

<!-- [Day 2 exercises](https://10mapz.com/tmap_course_cartography/tmap_course_cartography_ex_day2.html) -->
<!-- [Day 2 solutions](https://10mapz.com/tmap_course_cartography/tmap_course_cartography_ex_day2_solutions.html) -->

Day 3 (Friday 2nd of October)

9. Review of exercises
10. Insets <!-- [Slides](https://10mapz.com/tmap_course_cartography/session_10_insets.html) -->
11. Network maps <!-- [Slides](https://10mapz.com/tmap_course_cartography/session_11_networks.html) -->
12. Basemaps and final map design <!-- [Slides](https://10mapz.com/tmap_course_cartography/session_12_basemaps_design.html) -->

<!-- [Day 3 exercises](https://10mapz.com/tmap_course_cartography/tmap_course_cartography_ex_day3.html) -->
<!-- [Day 3 solutions](https://10mapz.com/tmap_course_cartography/tmap_course_cartography_ex_day3_solutions.html) -->


## Requirements

```r
install.packages(c("tmap", "cols4all", "tmap.glyphs", "tmap.cartogram", "tmap.networks",
                   "geofacet", "sfnetworks", "tidygraph", "maptiles", "tmaptools",
                   "dplyr", "tidyr", "ggplot2", "stars", "terra", "colorspace"))
remotes::install_github("rogerbeecham/gridmappr")
```

Session 12 downloads basemap tiles (internet connection required).

## Data

- `data/NL_commuter_OD_2024.csv`, `data/NL_municipality_centroids_2024.csv`: commuter flows, Statistics Netherlands (CBS), 2024, CC BY 4.0 (session 11). Helper functions to prepare these data are in `R/commuting.R`.
- `data/london_ttw.csv`: commuting between London boroughs, from the [gridmappr](https://github.com/rogerbeecham/gridmappr) repository (GPL-3) (session 7)
- All other data are included in tmap, spData, stars, sfnetworks, geofacet and gridmappr.


## Most important resources

Package home pages

-   [**tmap**](https://r-tmap.github.io/tmap/)
-   [**tmap.glyphs**](https://r-tmap.github.io/tmap.glyphs/)
-   [**tmap.cartogram**](https://r-tmap.github.io/tmap.cartogram/)
-   [**tmap.networks**](https://r-tmap.github.io/tmap.networks/)
-   [**cols4all**](https://cols4all.github.io/cols4all-R/)
-   [**geofacet**](https://hafen.github.io/geofacet/)
-   [**gridmappr**](https://github.com/rogerbeecham/gridmappr)
-   [**sf**](https://r-spatial.github.io/sf/)
-   [**sfnetworks**](https://luukvdmeer.github.io/sfnetworks/)
-   [**stars**](https://r-spatial.github.io/stars/)
-   [**terra**](https://rspatial.org/)

Books

- [*Spatial Data Visualization with tmap (in progress)*](https://tmap.geocompx.org) Martijn Tennekes and Jakub Nowosad
- [*Geocomputation with R*](https://r.geocompx.org/)  Robin Lovelace, Jakub Nowosad and Jannes Muenchow
- [*Spatial Data Science - With Applications in R*](https://r-spatial.org/book/) Edzer Pebesma and Roger Bivand
