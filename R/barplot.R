################################################################################
#                                                                              #
#                             By Derrick Demeveng                              #
#                                                                              #
################################################################################


# LOAD LIBRARIES ----------------------------------------------------------

if(!require("pacman")) install.packages("pacman")

pacman::p_load(ggplot2, dplyr, tibble)

# LOAD DATA ---------------------------------------------------------------

cars <- mtcars # R native dataset


# TRANSFORM DATA ----------------------------------------------------------

cars <- cars |> 
  tibble::rownames_to_column(var = "car_brand") |>
  dplyr::select(car_brand, mpg, cyl, disp) |>
  tidyr::pivot_longer(
    cols = c("mpg", "cyl", "disp"), 
    names_to = c("var"),
    values_to = "value"
  ) |>
  dplyr::group_by(car_brand, var) |>
  dplyr::summarise(
    val = sum(value)
  )
  

# VISUALIZATION -----------------------------------------------------------

ggplot2::ggplot(cars) +
  ggplot2::geom_bar(aes(x = car_brand, y = val, fill = var), stat = "identity", color = "white") +
  ggplot2::labs(
    title = "Barplot Demo Using mtcars Data",
    fill = "Group",
    y = "Count",
    x = "Car brand"
  ) +
  ggplot2::theme_minimal() +
  ggplot2::theme(
    plot.title = element_text(face = "bold", colour = "black", hjust = 0.5, size = 20),
    axis.text.x = element_text(angle = 90, size = 11),
    axis.text.y = element_text(size = 11),
    axis.title = element_text(face = "bold", size = 12),
    legend.key.spacing.y = unit(5, "pt"),
    legend.key.height = unit(30, "pt"),
    legend.text = element_text(size = 11)
  ) +
  ggplot2::scale_fill_brewer()


ggplot2::ggsave(filename = "barplot.jpeg", path = "output", width = 15, height = 9)







































