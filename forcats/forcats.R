# To get forcats is to install the whole tidyverse:
install.packages("tidyverse")

# Install just forcats:
install.packages("forcats")

# the the development version from GitHub:
install.packages("devtools")
devtools::install_github("tidyverse/forcats")

library(forcats)
library(dplyr)
library(ggplot2)

starwars %>% 
  filter(!is.na(species)) %>%
  count(species, sort = TRUE)

starwars %>%
  filter(!is.na(species)) %>%
  mutate(species = fct_lump(species, n = 3)) %>%
  count(species)

ggplot(starwars, aes(x = eye_color)) + 
  geom_bar() + 
  coord_flip()

starwars %>%
  mutate(eye_color = fct_infreq(eye_color)) %>%
  ggplot(aes(x = eye_color)) + 
  geom_bar() + 
  coord_flip()

starwars %>%
  glimpse()

# factor()
factor(
  x = c("1", "2", "3",
        "1", "2", "3"), 
  levels = c("1", "2", "3")
)

# asfactor()
starwars %>%
  mutate(species_fct = as.factor(species)) %>%
  select(name, starts_with("species"))

# lavel()
starwars %>%
  pull(species) %>%
  levels()

starwars %>%
  mutate(species_fct = as.factor(species)) %>%
  pull(species_fct) %>%
  levels()

# fct_count()
fct_count(starwars$species)

# fct_match
fct_match(starwars$sex, "male") %>% table()
# multiple levels at once.
fct_match(starwars$sex, c("male", "female")) %>% table()

# fct_uniwue()
fct_unique(starwars$sex)

# fct_c()
f1 <- as.factor(starwars$sex)
f2 <- as.factor(starwars$gender)

fct_c(f1, f2) %>% levels()

# fct_cross()
starwars %>%
  mutate(sex_gender = fct_cross(sex, gender)) %>%
  select(name, sex_gender, sex, gender)

# fct_unify()
f3 <- as.factor(starwars$eye_color)
fct_unify(list(f1, f2, f3)) %>% purrr::map(levels)


# fct_relevel()
starwars %>%
  mutate(sex_ordered = fct_relevel(sex, c("female", "male"))) %>%
  ggplot(data = ., aes(x = sex_ordered)) +
  geom_bar(stat = "count", fill = "white", color = "black")

# fct_infreq()
starwars %>%
  mutate(sex_ordered = fct_infreq(f = sex)) %>%
  ggplot(data = ., aes(x = sex_ordered)) +
  geom_bar(stat = "count", fill = "white", color = "black")

# fct_inseq()
starwars %>%
  mutate(birth_year_ordered = fct_inseq(as.factor(birth_year))) %>%
  ggplot(data = ., aes(x = birth_year_ordered)) +
  geom_bar(stat = "count", fill = "white", color = "black") +
  theme(axis.text.x = element_text(angle = 90))

# fct_inorder()
starwars %>%
  mutate(sex_ordered = fct_inorder(sex)) %>%
  ggplot(data = ., aes(x = sex_ordered)) +
  geom_bar(stat = "count", fill = "white", color = "black")

# fct_rev()
starwars %>%
  mutate(sex_ordered = fct_rev(f = sex)) %>%
  ggplot(data = ., aes(x = sex_ordered)) +
  geom_bar(stat = "count", fill = "white", color = "black") +
  coord_flip()
