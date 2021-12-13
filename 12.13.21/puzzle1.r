library(tidyverse)

input <- readLines("12.13.21/input.txt") %>% str_subset(".+")

coords <- input %>% str_subset(",") %>% str_split(",") %>% unlist %>%
  matrix(ncol = 2, byrow = T) %>% as.data.frame() %>%
  rename(x = 1, y = 2) %>% mutate_all(as.numeric)

instructions <- input %>% str_subset("fold") %>% str_extract("[xy].*") %>% 
  str_split("=") %>% unlist %>% matrix(ncol = 2, byrow = T) %>% as.data.frame() %>%
  rename(axis = 1, point = 2) %>% mutate(point = as.numeric(point))

fold <- function(df, axis, fold_at){
  df %>% mutate_at(axis, function(z){ifelse(z < fold_at, z, 2*fold_at - z)})
}

fold(coords, instructions$axis[[1]], instructions$point[[1]]) %>%
  n_distinct

