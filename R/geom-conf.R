#' Confident box based on center and confidence interval.
#'
#'
#' @eval rd_aesthetics("geom", "confbox")
#'
#' @inheritParams ggplot2::layer
#' @inheritParams ggplot2::geom_polygon
#' @rdname geom_confbox
#' @export
#' @importFrom ggplot2 layer
#' @importFrom ggplot2 ggproto
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 Geom
#' @importFrom ggplot2 GeomPolygon
#' @importFrom ggplot2 GeomSegment
#' @importFrom ggplot2 draw_key_polygon
#' @importFrom grid grobTree
geom_confbox <- function(mapping = NULL, data = NULL,
                        stat = "identity", position = "identity",
                        ...,
                        linejoin = "mitre",
                        na.rm = FALSE,
                        show.legend = NA,
                        inherit.aes = TRUE) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomConfbox,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      linejoin = linejoin,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname geom_confbox
#' @format NULL
#' @usage NULL
#' @export
GeomConfbox <- ggproto(
  "GeomConfbox", Geom,
  default_aes = aes(confline_col = "grey30", midline_col = "grey50",
                    colour = NA, fill = "grey60", size = 0.5,
                    midline_type = "dotted", linetype = 1,
                    alpha = NA),
  required_aes = c("x", "y", "r", "low", "upp"),
  draw_panel = function(self, data, panel_params, coord, linejoin = "mitre") {
    aesthetics <- setdiff(
      names(data), c("x", "y", "r", "low", "upp")
    )
    polys <- lapply(split(data, seq_len(nrow(data))), function(row) {
      d <- point_to_confbox(row$x, row$y, row$r, row$low, row$upp)
      confbox <- d$conf_box
      confline <- d$conf_line
      midline <- d$mid_line
      ## draw mid line
      mid_aes <- cbind(midline, new_data_frame(row[aesthetics]))
      mid_aes$colour <- row$midline_col
      mid_aes$linetype <- row$midline_type
      mid <- GeomSegment$draw_panel(mid_aes, panel_params, coord)
      ## draw conf box
      confbox_aes <- cbind(confbox,
                           new_data_frame(row[aesthetics])[rep(1, 5), ])
      confbox_aes$colour <- NA
      box <- GeomPolygon$draw_panel(confbox_aes, panel_params, coord)
      ## draw conf line
      confline_aes <- cbind(confline,
                            new_data_frame(row[aesthetics])[rep(1, 3), ])
      confline_aes$colour <- row$confline_col
      line <- GeomSegment$draw_panel(confline_aes, panel_params, coord)
      grid::gList(mid, box, line)
    })
    ggplot2:::ggname("confbox", do.call("grobTree", polys))
  },
  draw_key = draw_key_polygon
)

#' @noRd
point_to_confbox <- function(x, y, r, low, upp, width = 0.5) {
  to <- c(y - 0.5, y + 0.5)
  from <- c(-1, 1)
  r <- r / 2
  low <- low / 2
  upp <- upp / 2
  ## confidence box
  xmin <- - 0.5 * width  + x
  xmax <-  0.5 * width  + x
  ymin <- low + y
  ymax <- upp + y
  conf_box <- new_data_frame(list(
    y = c(ymax, ymax, ymin, ymin, ymax),
    x = c(xmin, xmax, xmax, xmin, xmin)
  ))
  ## confidence line
  xx <- rep_len(xmin, 3)
  xend <- rep_len(xmax, 3)
  yy <- c(low, r, upp) + y
  yend <- c(low, r, upp) + y

  conf_line <- new_data_frame(list(
    x = xx,
    y = yy,
    xend = xend,
    yend = yend
  ))
  ## mid line
  mid_line <- new_data_frame(list(
    x = x - 0.5,
    y = y,
    xend = x + 0.5,
    yend = y
  ))
  ## return confbox, confline, midline list
  list(conf_box = conf_box,
       conf_line = conf_line,
       mid_line = mid_line)
}

