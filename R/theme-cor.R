#' Create the default ggcor theme
#' @details The theme_cor, with no axis title, no background, no grid,
#'     made some adjustments to the x-axis label.
#' @param legend.position the position of legends ("none", "left", "right",
#'     "bottom", "top", or two-element numeric vector).
#' @param ... extra params passing to \code{\link[ggplot2]{theme}}.
#' @return The theme.
#' @rdname cor-theme
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_text
#' @importFrom ggplot2 element_blank
#' @importFrom ggplot2 element_rect
#' @importFrom ggplot2 element_line
#' @author Houyun Huang
#' @author Lei Zhou
#' @author Jian Chen
#' @author Taiyun Wei
#' @export
theme_cor <- function(legend.position = "right",
                      ...)
{
  theme(
    axis.text = element_text(size = 12, colour = "black"),
    axis.title = element_blank(),
    axis.line = element_blank(),
    axis.text.x.top = element_text(angle = 45, hjust = 0, vjust = 0),
    axis.text.x.bottom = element_text(angle = 45, hjust = 1, vjust = 1),
    panel.grid = element_blank(),
    panel.background = element_rect(fill = NA),
    legend.position = legend.position,
    ...
  )
}

#' @rdname cor-theme
#' @export
theme_cor2 <- function(legend.position = "right",
                      ...)
{
  theme(
    axis.text = element_text(size = 12, colour = "black"),
    axis.title = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x.top = element_text(angle = 45, hjust = 0, vjust = 0),
    axis.text.x.bottom = element_text(angle = 45, hjust = 1, vjust = 1),
    panel.background = element_rect(fill = NA),
    panel.grid = element_line(colour = "grey50", size = 0.25),
    legend.position = legend.position,
    ...
  )
}
