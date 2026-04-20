library(readr)
library(dplyr)
library(ggplot2)
library(httpgd)
library(reshape2)

if (requireNamespace("httpgd", quietly = TRUE)) {
  library(httpgd)
  if (dev.cur() == 1) hgd()
  options(device = "httpgd")
}

# setwd("C:/Users/cmart/Downloads/f1Estadistica")

if (dev.cur() == 1) hgd()
options(device = "httpgd")

pit_stops <- read_csv("pit_stops.csv", na = c("", "NA", "\\N"), show_col_types = FALSE)
races <- read_csv("races.csv", na = c("", "NA", "\\N"), show_col_types = FALSE)
results <- read_csv("results.csv", na = c("", "NA", "\\N"), show_col_types = FALSE)
constructors <- read_csv("constructors.csv", na = c("", "NA", "\\N"), show_col_types = FALSE)
circuits <- read_csv("circuits.csv", na = c("", "NA", "\\N"), show_col_types = FALSE)

datos_f1 <- pit_stops %>%
  inner_join(races %>% select(raceId, year, circuitId), by = "raceId") %>%
  inner_join(results %>% select(raceId, driverId, constructorId, grid, positionOrder), by = c("raceId", "driverId")) %>%
  inner_join(constructors %>% select(constructorId, team_name = name), by = "constructorId") %>%
  inner_join(circuits %>% select(circuitId, circuit_name = name), by = "circuitId") %>%
  mutate(duracion_segundos = milliseconds / 1000) %>%
  filter(duracion_segundos < 40, year >= 2018)

g1 <- ggplot(datos_f1, aes(x = duracion_segundos)) +
  geom_histogram(aes(y = after_stat(density)), bins = 30, fill = "steelblue", alpha = 0.5) +
  geom_density(color = "red", linewidth = 1) +
  labs(title = "Distribución de tiempos (Histograma + KDE)", x = "Segundos", y = "Densidad") +
  theme_minimal()
print(g1)

equipos_top <- c("Red Bull", "Ferrari", "Mercedes", "McLaren", "Williams")
datos_top <- datos_f1 %>% filter(team_name %in% equipos_top)

g2 <- ggplot(datos_top, aes(x = team_name, y = duracion_segundos, fill = team_name)) +
  geom_violin(alpha = 0.7) +
  geom_boxplot(width = 0.1, color = "black", outlier.shape = NA) +
  labs(title = "Densidad de tiempos por Escudería", x = "Equipo", y = "Segundos") +
  theme_minimal() + 
  theme(legend.position = "none")
print(g2)

pit_circuito <- datos_f1 %>%
  group_by(circuit_name) %>%
  summarise(tiempo_medio = mean(duracion_segundos, na.rm = TRUE)) %>%
  arrange(tiempo_medio) %>% 
  slice_tail(n = 10)

g3 <- ggplot(pit_circuito, aes(x = reorder(circuit_name, tiempo_medio), y = tiempo_medio)) +
  geom_col(fill = "darkred") +
  coord_flip() +
  labs(title = "Top 10 Circuitos con Pit Lane más lento", x = "Circuito", y = "Segundos (Media)") +
  theme_minimal()
print(g3)

g4 <- ggplot(datos_f1 %>% filter(grid > 0), aes(x = grid, y = positionOrder)) +
  geom_point(alpha = 0.1, color = "blue") +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Relación Grid vs Posición Final", x = "Salida (Grid)", y = "Llegada") +
  theme_minimal()
print(g4)

cor_data <- datos_f1 %>% 
  select(grid, positionOrder, duracion_segundos, year) %>% 
  cor(use = "complete.obs")

g5 <- ggplot(melt(cor_data), aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
  geom_text(aes(label = round(value, 2))) +
  labs(title = "Matriz de Correlación de Pearson") +
  theme_minimal()
print(g5)

g6 <- ggplot(datos_top, aes(x = year, y = duracion_segundos, color = team_name)) +
  stat_summary(fun = mean, geom = "line", linewidth = 1.2) +
  labs(title = "Evolución de Tiempos Medios (Tufte)", x = "Año", y = "Segundos") +
  theme_classic() +
  theme(panel.grid = element_blank())
print(g6)