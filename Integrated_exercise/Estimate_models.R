
library(brms)

# Estimate the models

M0 <- brm(
  fluency ~ 1 + (1|student),
  data = Subtitles,
  cores = 4,
  backend = "cmdstanr"
)

M1 <- brm(
  fluency ~ 1 + occasion + (1|student),
  data = Subtitles,
  cores = 4,
  backend = "cmdstanr"
)

M2 <- brm(
  fluency ~ 1 + occasion + condition + (1|student),
  data = Subtitles,
  cores = 4,
  backend = "cmdstanr"
)

M3 <- brm(
  fluency ~ 1 + occasion + condition + occasion*condition + (1|student),
  data = Subtitles,
  cores = 4,
  backend = "cmdstanr"
)

# Save the models

saveRDS(
  M0,
  file = here("Integrated_exercise", "M0.RDS")
)

saveRDS(
  M1,
  file = here("Integrated_exercise", "M1.RDS")
)

saveRDS(
  M2,
  file = here("Integrated_exercise", "M2.RDS")
)

saveRDS(
  M3,
  file = here("Integrated_exercise", "M3.RDS")
)

# loo cross-validation of the models

loo_M0 <- loo(M0)
loo_M1 <- loo(M1)
loo_M2 <- loo(M2)
loo_M3 <- loo(M3)

loo_models <- loo_compare(
  loo_M0,
  loo_M1,
  loo_M2,
  loo_M3
)

print(loo_models, simplify = F)

saveRDS(loo_models,
     file = here("Integrated_exercise", "loo_models.RDS"))
