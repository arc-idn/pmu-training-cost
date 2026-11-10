# Generate DUMMY data (invented values, for training only) and save it to data/dummy/.
# Real analyses replace these files with BPJS membership, utilisation and cost data.
set.seed(2026)
segments <- c("PBI APBN", "PBI APBD", "PPU", "PBPU", "BP")
years    <- 2019:2024
grid <- expand.grid(year = years, segment = segments, stringsAsFactors = FALSE)
# Members (millions) by segment, growing slowly
base_members <- c("PBI APBN" = 96, "PBI APBD" = 40, "PPU" = 60, "PBPU" = 35, "BP" = 5)
grid$members_m <- round(base_members[grid$segment] * (1 + 0.015) ^ (grid$year - 2019) * runif(nrow(grid), 0.98, 1.02), 2)
# Visits per member per year (primary care, outpatient, inpatient)
grid$fktp_rate <- round(runif(nrow(grid), 2.0, 3.2), 2)
grid$rjtl_rate <- round(runif(nrow(grid), 0.5, 1.1), 2)
grid$ritl_rate <- round(runif(nrow(grid), 0.05, 0.12), 3)
# Unit cost per visit (Rp thousand), rising with medical inflation
infl <- 1.05 ^ (grid$year - 2019)
grid$fktp_cost <- round(35 * infl, 1)
grid$rjtl_cost <- round(250 * infl * runif(nrow(grid), 0.95, 1.05), 1)
grid$ritl_cost <- round(6500 * infl * runif(nrow(grid), 0.95, 1.05), 1)
grid$contribution_per_member_month <- c("PBI APBN" = 42, "PBI APBD" = 42, "PPU" = 85, "PBPU" = 50, "BP" = 60)[grid$segment]
write.csv(grid, "data/dummy/jkn_dummy_segment_year.csv", row.names = FALSE)
cat("Dummy data written: data/dummy/jkn_dummy_segment_year.csv (", nrow(grid), "rows )\n")
